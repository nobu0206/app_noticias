import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news.dart';

class NewsProvider with ChangeNotifier {
  final String _apiKey = '22ed934286f44e96a4495a754314a19b'; 

  List<News> _newsList = [];
  List<News> _favorites = [];
  bool _isLoading = false; 

  List<News> get newsList => _newsList;
  List<News> get favorites => _favorites;
  bool get isLoading => _isLoading; 

  Future<void> fetchNews(String query) async {
    _isLoading = true;
    notifyListeners();

    final url =
        'https://newsapi.org/v2/everything?q=$query&language=es&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _newsList = (data['articles'] as List)
            .map((article) => News.fromJson(article))
            .toList();
      } else {
        _newsList = [];
        throw Exception('Error al cargar noticias');
      }
    } catch (e) {
      _newsList = [];
      debugPrint('Error en fetchNews: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(News news) {
    if (_favorites.contains(news)) {
      _favorites.remove(news);
    } else {
      _favorites.add(news);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(News news) => _favorites.contains(news);

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favorites',
      _favorites.map((n) => jsonEncode({'title': n.title})).toList(),
    );
  }
}

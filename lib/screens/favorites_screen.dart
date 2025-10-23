import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: provider.favorites.isEmpty
          ? const Center(child: Text('No hay noticias favoritas aún.'))
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return NewsCard(news: provider.favorites[index]);
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news.dart';
import '../providers/news_provider.dart';
import '../screens/news_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final News news;
  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => NewsDetailScreen(news: news)),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            if (news.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(news.imageUrl, fit: BoxFit.cover),
              ),
            ListTile(
              title: Text(news.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(news.source),
              trailing: IconButton(
                icon: Icon(
                  provider.isFavorite(news) ? Icons.favorite : Icons.favorite_border,
                  color: Colors.deepPurple,
                ),
                onPressed: () => provider.toggleFavorite(news),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

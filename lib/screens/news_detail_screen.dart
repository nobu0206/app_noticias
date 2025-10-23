import 'package:flutter/material.dart';
import '../models/news.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;
  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.source)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(news.imageUrl),
              ),
            const SizedBox(height: 12),
            Text(news.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(news.description, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                if (await canLaunchUrlString(news.url)) {
                  await launchUrlString(news.url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'No se pudo abrir la URL';
                }
              },
              icon: const Icon(Icons.open_in_browser),
              label: const Text("Leer artículo completo"),
            ),
          ],
        ),
      ),
    );
  }
}

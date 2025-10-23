import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/news_card.dart';
import 'favorites_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final TextEditingController _controller = TextEditingController();
  String query = 'deportes';

  @override
  void initState() {
    super.initState();
    // Carga inicial de noticias con la palabra “deportes”
    Future.microtask(() {
      Provider.of<NewsProvider>(context, listen: false).fetchNews(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Inteligentes'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
            ),
            tooltip: themeProvider.isDarkMode
                ? "Cambiar a modo claro"
                : "Cambiar a modo oscuro",
            onPressed: themeProvider.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: "Ver favoritos",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Buscar tema (ej: tecnología, salud, deportes...)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final input = _controller.text.trim();
                    if (input.isNotEmpty) {
                      setState(() => query = input);
                      provider.fetchNews(query);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: (value) {
                final input = value.trim();
                if (input.isNotEmpty) {
                  setState(() => query = input);
                  provider.fetchNews(query);
                }
              },
            ),
          ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.newsList.isEmpty
                    ? const Center(
                        child: Text(
                          "No se encontraron noticias. Intenta otra búsqueda.",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await provider.fetchNews(query);
                        },
                        child: ListView.builder(
                          itemCount: provider.newsList.length,
                          itemBuilder: (context, i) {
                            final news = provider.newsList[i];
                            return NewsCard(news: news);
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

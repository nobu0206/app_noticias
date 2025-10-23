class News {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String source;

  News({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'Sin título',
      description: json['description'] ?? 'Sin descripción',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      source: json['source']['name'] ?? 'Desconocido',
    );
  }
}

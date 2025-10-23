import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/news_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/news_list_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha los cambios del tema (oscuro o claro)
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noticias Inteligentes',
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Tema claro personalizado
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 3,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),

      // Tema oscuro personalizado
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.purpleAccent,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: Colors.white,
        ),
      ),

      // Pantalla principal
      home: const NewsListScreen(),
      routes: {
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}

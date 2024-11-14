import 'package:flutter/material.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App Estudiantil',
      theme: ThemeData(
        primaryColor: const Color(0xFF0386D0),
        scaffoldBackgroundColor: Colors.blue[50],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        navigationBarTheme: const NavigationBarThemeData(backgroundColor: Colors.blue)
      ),
      initialRoute: '/',
      routes: appRoutes, // Llamamos a las rutas desde routes.dart
    );
  }
}

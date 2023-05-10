import 'package:flutter/material.dart';
import 'package:wall_print_ai_web/pages/main_page.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visualio',
      theme: theme(),
      home: const MainPage(),
    );
  }
}

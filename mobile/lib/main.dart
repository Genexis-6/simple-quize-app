import 'package:flutter/material.dart';
import 'package:mobile/features/meme/view/pages/home_meme_screen.dart';

void main() {
  runApp(const MemeApp());
}

class MemeApp extends StatelessWidget {
  const MemeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Meme App',
      home: const HomeMemeScreen(),
    );
  }
}

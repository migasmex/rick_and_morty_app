import 'package:flutter/material.dart';
import 'package:rick_and_morty/app_colors.dart';
import 'package:rick_and_morty/feature/pages/character_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appColors,
      home: const CharacterList(),
    );
  }
}

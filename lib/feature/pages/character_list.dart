import 'package:flutter/material.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Character list"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
    );
  }
}

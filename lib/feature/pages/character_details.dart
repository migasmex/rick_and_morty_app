import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 47, 47, 52),
      appBar: AppBar(
        title: Text(character.name),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 47, 47, 52),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(character.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status: ${character.status}', style: textStyle),
              Text('Species: ${character.species}', style: textStyle),
              Text('Location: ${character.location.name}', style: textStyle),
              Text(
                  character.type == ''
                      ? 'Type: unknown'
                      : 'Type: ${character.type}',
                  style: textStyle),
              Text(
                "Gender: ${character.gender}",
                style: textStyle,
              ),
              Text(
                "Origin: ${character.origin.name}",
                style: textStyle,
              ),
              Text(
                "Url: ${character.url}",
                style: textStyle,
              ),
              Text(
                "Character created in: ${character.created}",
                style: textStyle,
              ),
              Text(
                "Episode: ${character.episodeName ?? 'Unknown'}",
                style: textStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

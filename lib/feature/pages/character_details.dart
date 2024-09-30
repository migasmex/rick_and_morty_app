import 'package:flutter/material.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/feature/pages/character_list.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: Column(
        children: [
          CharacterImage(character: character),
          const SizedBox(height: 20),
          DetailedInfo(character: character),
        ],
      ),
    );
  }
}

class BuildRow extends StatelessWidget {
  const BuildRow({
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: textStyle.copyWith(fontWeight: FontWeight.normal),
          ),
          Text(
            value,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.character});
  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(character.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DetailedInfo extends StatelessWidget {
  const DetailedInfo({super.key, required this.character});
  final Character character;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildRow(title: 'Status', value: character.status),
        BuildRow(title: 'Location', value: character.location.name),
        BuildRow(title: 'Species', value: character.species),
        BuildRow(
            title: 'Type',
            value: character.type.isEmpty ? 'unknown' : character.type),
        BuildRow(title: 'Gender', value: character.gender),
        BuildRow(title: 'Origin', value: character.location.name),
        BuildRow(title: 'URL', value: character.url),
        BuildRow(title: 'Character created in', value: character.created),
        BuildRow(title: 'Episode', value: character.episodeName ?? 'unknown'),
      ],
    );
  }
}

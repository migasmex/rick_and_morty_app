import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';
import 'package:rick_and_morty/domain/usecase/get_character_usecase.dart';
import 'package:rick_and_morty/feature/bloc/character_list_bloc.dart';
import 'package:rick_and_morty/feature/pages/character_details.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final dio = Dio();
  late Future<List<Character>> characters;
  late CharacterListBloc characterListBloc;

  @override
  void initState() {
    super.initState();
    final characterRepository = CharacterRepository(dio: dio);
    final getCharactersUseCase =
        GetCharactersUseCase(repository: characterRepository);
    characterListBloc = CharacterListBloc(getCharactersUseCase);
    characterListBloc.add(LoadCharacterListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Character list'),
        ),
        body: BlocBuilder<CharacterListBloc, CharacterListState>(
          bloc: characterListBloc,
          builder: (context, state) {
            if (state is CharacterListInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CharacterListLoaded) {
              return ListView.builder(
                itemCount: state.characterList.length,
                itemBuilder: (context, index) => CharacterCard(
                  character: state.characterList[index],
                ),
              );
            } else if (state is CharacterListError) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ));
  }
}

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CharacterDetailsPage(
                      character: character,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 58, 58, 58),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CharacterImage(imageUrl: character.image),
              const SizedBox(width: 10),
              Expanded(child: CharacterInfo(character: character)),
            ],
          ),
        ),
      ),
    );
  }
}

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          character.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        CharacterStatusRow(
            status: character.status, species: character.species),
        const SizedBox(height: 10),
        const Text(
          "Last known location:",
          style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
        ),
        Expanded(
          child: Text(
            character.location.name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "First seen is:",
          style: TextStyle(color: Color.fromARGB(255, 169, 168, 168)),
        ),
        Expanded(
          child: Text(
            character.episodeName ?? 'unknown',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class CharacterStatusRow extends StatelessWidget {
  const CharacterStatusRow(
      {super.key, required this.status, required this.species});

  final String status;
  final String species;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 10,
          color: status == "Alive"
              ? Colors.green
              : status == "Dead"
                  ? Colors.red
                  : Colors.grey,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            '$status - $species',
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 240, 240, 240),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

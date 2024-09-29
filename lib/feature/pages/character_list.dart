import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';
import 'package:rick_and_morty/feature/bloc/character_list_bloc.dart';

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
    characterListBloc = CharacterListBloc(characterRepository);
    characterListBloc.add(LoadCharacterListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 47, 47, 52),
        appBar: AppBar(
          title: Text('Character list'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 47, 47, 52),
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
              return const Center(child: Text("unlucky"));
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 58, 58),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(character.image),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle,
                          size: 10,
                          color: character.status == "Alive"
                              ? Colors.green
                              : character.status == "Dead"
                                  ? Colors.red
                                  : Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          '${character.status} - ${character.species}',
                          style: TextStyle(
                              color: Color.fromARGB(255, 240, 240, 240),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Last known location:",
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 168, 168),
                    ),
                  ),
                  Text(
                    character.location.name,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "First seen is:",
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 168, 168),
                    ),
                  ),
                  Text(
                    "somewhere",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

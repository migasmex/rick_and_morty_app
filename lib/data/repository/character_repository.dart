import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';

class CharacterRepository implements AbstractCharacterRepository {
  final Dio dio;

  CharacterRepository({required this.dio});

  @override
  Future<List<Character>> getCharacters() async {
    try {
      List<Character> charactersFromApi = await fetchCharactersFromApi();
      await fetchEpisodeNameFromApi(charactersFromApi);
      return charactersFromApi;
    } catch (e) {
      print('Error fetching: $e');
      return [];
    }
  }

  Future<List<Character>> fetchCharactersFromApi() async {
    List<Character> allCharacters = [];
    final firstResponse = await dio.get(
        'https://rickandmortyapi.com/api/character',
        queryParameters: {'page': 1});
    final totalPages = firstResponse.data['info']['pages'];

    for (int page = 1; page < totalPages; page++) {
      final response = await dio.get(
          "https://rickandmortyapi.com/api/character",
          queryParameters: {'page': page});
      final data = response.data;
      final List<Character> characters = (data['results'] as List)
          .map((characterJson) => Character.fromJson(characterJson))
          .toList();
      allCharacters.addAll(characters);
    }
    return allCharacters;
  }

  Future<void> fetchEpisodeNameFromApi(List<Character> characters) async {
    for (var character in characters) {
      if (character.episode.isNotEmpty) {
        String episodeUrl = character.episode.first;
        try {
          final response = await dio.get(episodeUrl);
          final data = response.data;
          String episodeName = data['name'];
          character.episodeName = episodeName;
        } catch (e) {
          print('Error fetching: $e');
        }
      }
    }
  }
}

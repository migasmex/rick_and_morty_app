import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/domain/repository/character_repository.dart';

class GetCharactersUseCase {
  final AbstractCharacterRepository repository;

  GetCharactersUseCase({required this.repository});

  Future<List<Character>> call() async {
    return await repository.getCharacters();
  }
}

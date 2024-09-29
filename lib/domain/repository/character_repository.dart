import 'package:rick_and_morty/data/models/character.dart';

abstract class AbstractCharacterRepository {
  Future<List<Character>> getCharacters();
}

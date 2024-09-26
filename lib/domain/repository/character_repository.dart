import 'package:rick_and_morty/domain/models/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacter();
}

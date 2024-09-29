part of 'character_list_bloc.dart';

abstract class CharacterListState {}

class CharacterListInitial extends CharacterListState {}

class CharacterListLoaded extends CharacterListState {
  CharacterListLoaded({required this.characterList});
  final List<Character> characterList;
}

class CharacterListError extends CharacterListState {
  final String message;

  CharacterListError(this.message);
}

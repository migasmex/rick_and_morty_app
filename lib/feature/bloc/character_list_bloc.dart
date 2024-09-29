import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/models/character.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc(this.characterRepository) : super(CharacterListInitial()) {
    on<LoadCharacterListEvent>((event, emit) async {
      emit(CharacterListInitial());
      try {
        final characters = await characterRepository.fetchCharactersFromApi();
        emit(CharacterListLoaded(characterList: characters));
      } catch (e) {
        emit(CharacterListError(e.toString()));
      }
    });
  }
  final CharacterRepository characterRepository;
}

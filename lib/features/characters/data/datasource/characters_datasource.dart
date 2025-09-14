import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';

abstract interface class CharactersDataSource {
  Future<List<CharactersModel>> getCharacters(int page);
}

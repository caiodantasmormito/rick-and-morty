
import 'package:rick_and_morty/core/domain/failure.dart';
import 'package:rick_and_morty/features/characters/data/datasource/characters_datasource.dart';
import 'package:rick_and_morty/features/characters/data/exceptions/exceptions.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/failure/failure.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersDataSource _getCharactersDatasource;

  CharactersRepositoryImpl(
      {required CharactersDataSource getCharactersDatasource})
      : _getCharactersDatasource = getCharactersDatasource;

  @override
  Future<(Failure?, List<CharactersEntity>?)> getCharacters({int page = 1}) async {
    try {
      final result = await _getCharactersDatasource.getCharacters(page);

      return (null, result);
    } on GetCharactersException catch (error) {
      return (
        GetCharactersFailure(message: error.message),
        null,
      );
    }
  }
}

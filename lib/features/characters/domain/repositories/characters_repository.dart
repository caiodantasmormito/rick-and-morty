

import 'package:rick_and_morty/core/domain/failure.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

abstract class CharactersRepository {
  Future<(Failure?, List<CharactersEntity>?)> getCharacters({int page = 1});
}

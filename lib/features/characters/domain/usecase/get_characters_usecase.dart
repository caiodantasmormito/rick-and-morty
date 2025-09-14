
import 'package:rick_and_morty/core/domain/failure.dart';
import 'package:rick_and_morty/core/domain/usecase.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';

class GetCharactersUsecase implements UseCase<List<CharactersEntity>, Params> {
  final CharactersRepository _getCharactersRepository;
  GetCharactersUsecase(
      {required CharactersRepository getCharactersRepository})
      : _getCharactersRepository = getCharactersRepository;

  @override
  Future<(Failure?, List<CharactersEntity>?)> call(Params params) =>
      _getCharactersRepository.getCharacters(page: params.page);
}

class Params {
  final int page;

  Params({required this.page});
}
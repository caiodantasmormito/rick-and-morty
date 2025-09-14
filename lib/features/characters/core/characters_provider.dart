import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/infra/http_client.dart';
import 'package:rick_and_morty/features/characters/data/datasource/characters_datasource.dart';
import 'package:rick_and_morty/features/characters/data/datasource/characters_datasource_impl.dart';
import 'package:rick_and_morty/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty/features/characters/domain/usecase/get_characters_usecase.dart';

sealed class CharactersInject {
  static final List<Provider> providers = [
    Provider<CharactersDataSource>(
      create: (context) => CharactersDataSourceImpl(httpClient: HttpClient()),
    ),
    Provider<CharactersRepository>(
      create: (context) => CharactersRepositoryImpl(
        getCharactersDatasource: context.read<CharactersDataSource>(),
      ),
    ),
    Provider<GetCharactersUsecase>(
      create: (context) => GetCharactersUsecase(
        getCharactersRepository: context.read<CharactersRepository>(),
      ),
    ),
  ];
}

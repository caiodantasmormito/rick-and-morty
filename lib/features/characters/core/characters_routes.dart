
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/usecase/get_characters_usecase.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/get_characters/get_characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/character_detail_page.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/characters_page.dart';

sealed class CharactersRoutes {
  static final List<RouteBase> routes = [
    GoRoute(
        path: CharactersPage.routeName,
        builder: (context, state) {
          return BlocProvider<GetCharactersBloc>(
              create: (context) => GetCharactersBloc(
                    useCase: context.read<GetCharactersUsecase>(),
                  ),
              child: const CharactersPage());
        }),
         GoRoute(
          path: 'detail',
          name: CharacterDetailPage.routeName,
          builder: (context, state) {
            
            final character = state.extra as CharactersEntity;
            return CharacterDetailPage(character: character);
          },
        ),
  ];
}

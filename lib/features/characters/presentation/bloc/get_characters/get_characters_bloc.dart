import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';
import 'package:rick_and_morty/features/characters/domain/usecase/get_characters_usecase.dart';

part 'get_characters_event.dart';
part 'get_characters_state.dart';

class GetCharactersBloc extends Bloc<GetCharactersEvent, GetCharactersState> {
  final GetCharactersUsecase useCase;
  int currentPage = 1;
  bool hasNextPage = false;
  List<CharactersEntity> allCharacters = [];

  GetCharactersBloc({required this.useCase}) : super(GetCharactersInitial()) {
    on<GetCharacters>(_onGetCharacters);
    
  }

  Future<void> _onGetCharacters(
    GetCharacters event,
    Emitter<GetCharactersState> emit,
  ) async {
    emit(GetCharactersLoading());
    
    final (failure, result) = await useCase(Params(page: event.page));

    if (failure == null && result != null) {
      allCharacters = result;
      hasNextPage = result.length < 20; 
      currentPage = event.page;
      
      emit(GetCharactersSuccess(
        data: allCharacters,
        currentPage: currentPage,
        hasNextPage: hasNextPage,
      ));
    } else {
      emit(GetCharactersError(message: failure?.message ?? 'Erro desconhecido'));
    }
  }

}
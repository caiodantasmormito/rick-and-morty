part of 'get_characters_bloc.dart';

sealed class GetCharactersState extends Equatable {
  const GetCharactersState();

  @override
  List<Object?> get props => [];
}

class GetCharactersInitial extends GetCharactersState {}

final class GetCharactersLoading extends GetCharactersState {}

final class GetCharactersError extends GetCharactersState {
  final String? message;

  const GetCharactersError({required this.message});
}

final class GetCharactersSuccess extends GetCharactersState {
   final List<CharactersEntity> data;
  final int currentPage;
  final bool hasNextPage;
  
  const GetCharactersSuccess({
    required this.data,
    required this.currentPage,
    required this.hasNextPage,
  });
  @override
  List<Object> get props => [data, currentPage, hasNextPage];
}

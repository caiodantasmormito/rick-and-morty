part of 'get_characters_bloc.dart';

abstract class GetCharactersEvent extends Equatable {
  const GetCharactersEvent();

  @override
  List<Object> get props => [];
}

class GetCharacters extends GetCharactersEvent {
  final int page;

  const GetCharacters({this.page = 1});

  @override
  List<Object> get props => [page];
}

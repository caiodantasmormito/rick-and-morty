
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/core/infra/http_client.dart';
import 'package:rick_and_morty/features/characters/data/datasource/characters_datasource.dart';
import 'package:rick_and_morty/features/characters/data/exceptions/exceptions.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';

class CharactersDataSourceImpl implements CharactersDataSource {
  final HttpClient _httpClient;

  CharactersDataSourceImpl({
    required HttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<List<CharactersModel>> getCharacters(int page) async {
    try {
      final Response response = await _httpClient.get(
        '/character?page=$page',
      );

      final List<dynamic> characters = response.data['results'];

      return characters
          .map((characters) => CharactersModel.fromMap(characters))
          .toList();
      
    } on DioException catch (e, s) {
      if (kDebugMode) {
        debugPrintStack(label: e.toString(), stackTrace: s);
      }
      final Map<String, dynamic> errors = e.response!.data['errors'];

      throw GetCharactersException(
        message: errors.toString(),
      );
    } catch (e) {
      throw const GetCharactersException(
        message: 'Erro inesperado',
      );
    }
  }


}

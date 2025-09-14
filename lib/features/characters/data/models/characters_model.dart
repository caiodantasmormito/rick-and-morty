import 'dart:convert';

import 'package:rick_and_morty/features/characters/domain/entities/characters_entity.dart';

final class CharactersModel extends CharactersEntity {
  const CharactersModel({
    required super.name,
    required super.id,
    required super.gender,
    required super.image,
    required super.location,
    required super.species,
    required super.status,
    required super.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'gender': gender,
      'image': image,
      'location': location,
      'species': species,
      'status': status,
      'type': type,
    };
  }

  factory CharactersModel.fromMap(Map<String, dynamic> json) {
    return CharactersModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      location: json['location']['name'] ?? '',
      species: json['species'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CharactersModel.fromJson(String source) =>
      CharactersModel.fromMap(json.decode(source));
}

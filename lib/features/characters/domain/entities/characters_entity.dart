import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';

class CharactersEntity extends Equatable {
  final String name;
  final int id;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String location;

  
  const CharactersEntity({
    required this.name, 
    required this.id,
    required this.gender,
    required this.image,
    required this.location,
    required this.species,
    required this.status,
    required this.type,

    
  });

  @override
  List<Object?> get props => [
        name,
        id,
        gender,
        image,
        location,
        species,
        status,
        type,

        
      ];

       CharactersEntity copyWith({
    String? name,
    int? id,
    String? gender,
    String? image,
    String? location,
    String? species,
    String? status,
    String? type,
  }) {
    return CharactersEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      location: location ?? this.location,
      species: species ?? this.species,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }

  CharactersModel toModel() => CharactersModel(
        name: name,
        id: id,
        gender: gender,
        image: image,
        location: location,
        species: species,
        status: status,
        type: type,

      );
}

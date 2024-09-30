import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/data/models/location.dart';
part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final Location location;
  final String image;
  final List<String> episode;
  final String type;
  final String gender;
  final Location origin;
  final String url;
  final String created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    required this.image,
    required this.episode,
    required this.type,
    required this.gender,
    required this.origin,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

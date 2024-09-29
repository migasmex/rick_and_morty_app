import 'package:rick_and_morty/domain/entities/location.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String type;
  final Location location;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.type,
    required this.location,
    required this.image,
  });
}

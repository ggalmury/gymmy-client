import 'package:gymmy_client/models/sets.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Workout {
  final String name;
  final List<Sets> sets;

  Workout({required this.name, List<Sets>? sets}) : sets = sets ?? [Sets()];
}

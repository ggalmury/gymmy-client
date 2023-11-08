import 'package:gymmy_client/models/sets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@JsonSerializable()
class Workout {
  final String name;
  final List<Sets> sets;

  Workout({required this.name, List<Sets>? sets})
      : sets = sets ?? [Sets(count: 10, weight: 10)];

  Workout copyWith({List<Sets>? sets}) {
    return Workout(name: name, sets: sets ?? this.sets);
  }

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}

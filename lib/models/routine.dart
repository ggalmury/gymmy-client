import 'package:gymmy_client/models/workout.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine.g.dart';

@JsonSerializable()
class Routine {
  final DateTime date;
  final String target;
  final List<Workout> workouts;

  Routine({required this.date, required this.target, required this.workouts});

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);
  Map<String, dynamic> toJson() => _$RoutineToJson(this);
}

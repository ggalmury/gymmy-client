import 'package:gymmy_client/models/workout.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

@JsonSerializable()
class Plan {
  final DateTime date;
  final String target;
  final List<Workout> workouts;

  Plan({required this.date, required this.target, required this.workouts});

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

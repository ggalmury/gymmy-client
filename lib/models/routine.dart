import 'package:gymmy_client/models/workout.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Routine {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final List<Workout> workouts;

  Routine({required this.date, required this.workouts});

  Routine copyWith({
    String? date,
    List<Workout>? workouts,
  }) {
    return Routine(
      date: date ?? this.date,
      workouts: workouts ?? this.workouts,
    );
  }

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);
  Map<String, dynamic> toJson() => _$RoutineToJson(this);
}

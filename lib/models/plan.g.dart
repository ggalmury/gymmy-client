// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      date: DateTime.parse(json['date'] as String),
      target: json['target'] as String,
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'target': instance.target,
      'workouts': instance.workouts,
    };

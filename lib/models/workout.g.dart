// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      name: json['name'] as String,
      sets: (json['sets'] as List<dynamic>?)
          ?.map((e) => Sets.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'name': instance.name,
      'sets': instance.sets,
    };

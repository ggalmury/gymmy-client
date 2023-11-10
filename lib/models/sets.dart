import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sets.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Sets {
  @HiveField(0)
  final int count;

  @HiveField(1)
  final int weight;

  Sets({required this.count, required this.weight});

  Sets copyWith({int? count, int? weight}) {
    return Sets(count: count ?? this.count, weight: weight ?? this.weight);
  }

  factory Sets.fromJson(Map<String, dynamic> json) => _$SetsFromJson(json);
  Map<String, dynamic> toJson() => _$SetsToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'sets.g.dart';

@JsonSerializable()
class Sets {
  final int count;
  final int weight;

  Sets({required this.count, required this.weight});

  Sets copyWith({int? count, int? weight}) {
    return Sets(count: count ?? this.count, weight: weight ?? this.weight);
  }

  factory Sets.fromJson(Map<String, dynamic> json) => _$SetsFromJson(json);
  Map<String, dynamic> toJson() => _$SetsToJson(this);
}

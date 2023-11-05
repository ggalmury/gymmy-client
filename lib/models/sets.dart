import 'package:json_annotation/json_annotation.dart';

part 'sets.g.dart';

@JsonSerializable()
class Sets {
  int count = 0;
  int weight = 0;

  Sets();

  factory Sets.fromJson(Map<String, dynamic> json) => _$SetsFromJson(json);
  Map<String, dynamic> toJson() => _$SetsToJson(this);
}

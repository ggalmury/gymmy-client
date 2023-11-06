import 'package:json_annotation/json_annotation.dart';

part 'sets.g.dart';

@JsonSerializable()
class Sets {
  int count = 10;
  int weight = 10;

  Sets();

  factory Sets.fromJson(Map<String, dynamic> json) => _$SetsFromJson(json);
  Map<String, dynamic> toJson() => _$SetsToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sets.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SetsAdapter extends TypeAdapter<Sets> {
  @override
  final int typeId = 2;

  @override
  Sets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sets(
      count: fields[0] as int,
      weight: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Sets obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.count)
      ..writeByte(1)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sets _$SetsFromJson(Map<String, dynamic> json) => Sets(
      count: json['count'] as int,
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$SetsToJson(Sets instance) => <String, dynamic>{
      'count': instance.count,
      'weight': instance.weight,
    };

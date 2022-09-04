// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupAdapter extends TypeAdapter<DbGroup> {
  @override
  final int typeId = 1;

  @override
  DbGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DbGroup(
      name: fields[0] as String,
      numberOfSubgroups: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DbGroup obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.numberOfSubgroups);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

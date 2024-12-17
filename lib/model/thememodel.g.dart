// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thememodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThememodelAdapter extends TypeAdapter<Thememodel> {
  @override
  final int typeId = 1;

  @override
  Thememodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Thememodel(
      fields[0] as int,
      Color(fields[1] as int),
      Color(fields[2] as int),
      Color(fields[3] as int)
    );
  }

  @override
  void write(BinaryWriter writer, Thememodel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.indexTheme)
      ..writeByte(1)
      ..write(obj.background.value)
      ..writeByte(2)
      ..write(obj.widget.value)
      ..writeByte(3)
      ..write(obj.text.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThememodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

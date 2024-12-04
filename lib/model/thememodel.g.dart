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
    // Read the number of fields
    final numOfFields = reader.readByte();

    // Read each field as dynamic and store it in a map
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Convert the stored int values back to Color objects
    return Thememodel(
      Color(fields[0] as int), // Convert to Color
      Color(fields[1] as int), // Convert to Color
      Color(fields[2] as int), // Convert to Color
    );
  }

  @override
  void write(BinaryWriter writer, Thememodel obj) {
    // Write the number of fields (3 for background, widget, and text)
    writer
      ..writeByte(3)
      ..writeByte(0) // Write background color as int
      ..write(obj.background.value) // Store as int (ARGB)
      ..writeByte(1) // Write widget color as int
      ..write(obj.widget.value) // Store as int (ARGB)
      ..writeByte(2) // Write text color as int
      ..write(obj.text.value); // Store as int (ARGB)
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiseaseAdapter extends TypeAdapter<Disease> {
  @override
  final int typeId = 1;

  @override
  Disease read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Disease(
      name: fields[0] as String,
      imagePath: fields[4] as String,
    )
      ..symptoms = (fields[1] as List).cast<String>()
      ..causes = (fields[2] as List).cast<String>()
      ..treatment = (fields[3] as List).cast<String>()
      ..dateTime = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Disease obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.symptoms)
      ..writeByte(2)
      ..write(obj.causes)
      ..writeByte(3)
      ..write(obj.treatment)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

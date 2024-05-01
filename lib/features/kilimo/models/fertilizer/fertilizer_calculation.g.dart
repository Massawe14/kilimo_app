// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fertilizer_calculation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FertilizerCalculationAdapter extends TypeAdapter<FertilizerCalculation> {
  @override
  final int typeId = 2;

  @override
  FertilizerCalculation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FertilizerCalculation(
      cropType: fields[0] as String,
      nitrogen: fields[1] as double,
      phosphorus: fields[2] as double,
      potassium: fields[3] as double,
      unit: fields[4] as String,
      plotSize: fields[5] as double,
      urea: fields[6] as double,
      ssp: fields[7] as double,
      mop: fields[8] as double,
      ureaBags: fields[9] as int,
      sspBags: fields[10] as int,
      mopBags: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FertilizerCalculation obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.cropType)
      ..writeByte(1)
      ..write(obj.nitrogen)
      ..writeByte(2)
      ..write(obj.phosphorus)
      ..writeByte(3)
      ..write(obj.potassium)
      ..writeByte(4)
      ..write(obj.unit)
      ..writeByte(5)
      ..write(obj.plotSize)
      ..writeByte(6)
      ..write(obj.urea)
      ..writeByte(7)
      ..write(obj.ssp)
      ..writeByte(8)
      ..write(obj.mop)
      ..writeByte(9)
      ..write(obj.ureaBags)
      ..writeByte(10)
      ..write(obj.sspBags)
      ..writeByte(11)
      ..write(obj.mopBags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FertilizerCalculationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

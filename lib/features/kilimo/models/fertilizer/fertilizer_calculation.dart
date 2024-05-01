import 'package:hive/hive.dart';

part 'fertilizer_calculation.g.dart'; // Auto-generated file

@HiveType(typeId: 2)
class FertilizerCalculation {
  @HiveField(0)
  late String cropType;

  @HiveField(1)
  late double nitrogen;

  @HiveField(2)
  late double phosphorus;

  @HiveField(3)
  late double potassium;

  @HiveField(4)
  late String unit;

  @HiveField(5)
  late double plotSize;

  @HiveField(6)
  late double urea;

  @HiveField(7)
  late double ssp;

  @HiveField(8)
  late double mop;

  @HiveField(9)
  late int ureaBags;

  @HiveField(10)
  late int sspBags;

  @HiveField(11)
  late int mopBags;

  // Constructor
  FertilizerCalculation({
    required this.cropType,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.unit,
    required this.plotSize,
    required this.urea,
    required this.ssp,
    required this.mop,
    required this.ureaBags,
    required this.sspBags,
    required this.mopBags,
  });
}
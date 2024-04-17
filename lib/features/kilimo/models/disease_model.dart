import 'package:hive/hive.dart';

part 'disease_model.g.dart';

@HiveType(typeId: 0)
class Disease {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> symptoms;

  @HiveField(2)
  List<String> causes;

  @HiveField(3)
  List<String> treatment;

  Disease({
    required this.name,
    required this.symptoms,
    required this.causes,
    required this.treatment,
  });
}

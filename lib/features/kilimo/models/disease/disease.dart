import 'package:hive/hive.dart';

part 'disease.g.dart';

@HiveType(typeId: 1)
class Disease {
  @HiveField(0)
  String name;

  @HiveField(1)
  late List<String> symptoms;

  @HiveField(2)
  late List<String> causes;

  @HiveField(3)
  late List<String> treatment;

  @HiveField(4)
  late String imagePath;

  @HiveField(5)
  late DateTime dateTime;

  Disease({required this.name, required this.imagePath}) {
    dateTime = DateTime.now();

    switch (name) {
      case "Northern leaf blight":
        symptoms = ['Large grey cigar-shaped lesions'];
        causes = [
          'Is caused by the fungus called  Exserohilium turcicum',
          'Moderate to cool temperatures',
          'Relatively high humidity level',
        ];
        treatment = [
          'Antimalarial medications',
          'Supportive care',
        ];
        break;

      case "Common rust":
        symptoms = [
          'A number of small tan spots develop on both the surfaces of the leaf and as a result',
          'The photosynthesis of the leaf reduces drastically',
        ];
        causes = [
          'High humidity levels',
          'Cold temperatures',
        ];
        treatment = [
          'Rest',
          'Fluids',
          'Over-the-counter medications',
        ];
        break;

      case "The Gray leaf spot":
        symptoms = [
          'Linear (and rectangular) lesions on the lower surface of the leaf in the early stage',
          'Leaf later turns into rust spots',
        ];
        causes = [
          'Cercospora zeae-maydis fungal pathogen',
          'Moderate to cool temperatures',
          'Relatively high humidity level',
        ];
        treatment = [
          'Antimalarial medications',
          'Supportive care',
        ];
        break;

      case "Healthy maize leaves":
        symptoms = ['Healthy'];
        causes = ['Healthy'];
        treatment = ['Healthy'];
        break;

      default:
        symptoms = ["N/A"];
        causes = ["N/A"];
        treatment = ["N/A"];
        break;
    }
  }
}

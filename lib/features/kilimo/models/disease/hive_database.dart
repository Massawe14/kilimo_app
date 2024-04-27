import 'package:hive/hive.dart';

import 'disease.dart';

class Boxes {
  static Box<Disease> getDiseases() => Hive.box<Disease>('plant_diseases');
}

class HiveService {

  final box = Boxes.getDiseases();

  // Store disease
  Future addDisease(Disease disease) async {
    await box.add(disease);
  }
  
}

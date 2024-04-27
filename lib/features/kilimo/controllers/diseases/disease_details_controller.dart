import 'package:get/get.dart';

import '../../models/disease/disease.dart';

class DiseaseDetailsController extends GetxController { // Extend GetxController
  late Disease _disease;

  Disease get disease => _disease;

  void setDiseaseValue(Disease disease) {
    _disease = disease;
    update();
  }
}

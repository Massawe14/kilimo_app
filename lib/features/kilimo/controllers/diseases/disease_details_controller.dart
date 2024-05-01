import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../models/disease/disease.dart';

class DiseaseDetailsController extends GetxController {
  final _disease = Rxn<Disease>();

  Disease? get disease => _disease.value;

  final _isLoading = false.obs; 
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final _errorMessage = Rxn<String>(); 
  String? get errorMessage => _errorMessage.value;

  void setDiseaseValue(Disease disease) {
    _disease.value = disease;
    update();
  }

  Future<void> fetchDiseaseDetails(int diseaseId) async {
    try {
      isLoading = true; // Set loading state

      // Replace this with your actual data fetching logic
      final diseasesBox = await Hive.openBox('diseasesBox'); 
      final disease = diseasesBox.get(diseaseId) as Disease?;

      if (disease != null) {
        setDiseaseValue(disease); // Assuming you kept the setDiseaseValue method
      } else {
        _errorMessage.value = 'Disease not found in Hive database'; // Update error message
      }
    } catch (error) {
      _errorMessage.value = error.toString(); // Store error message
    } finally {
      isLoading = false; 
    }
  }
}

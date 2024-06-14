import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../util/popups/loaders.dart';
import '../../models/disease/disease_model.dart';

class DiseaseController extends GetxController {
  var isLoading = false.obs;
  var disease = DiseaseModal.empty().obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void getDiseaseDetails(String diseaseName) async {
    isLoading(true);
    try {
      var snapshot = await _db.collection('Diseases').doc(diseaseName).get();
      if (snapshot.exists) {
        disease.value = DiseaseModal.fromSnapshot(snapshot);
      } else {
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Disease not found',
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error', 
        message: e.toString(),
      );
    } finally {
      isLoading(false);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../util/helpers/helper_functions.dart';
import '../../models/fertilizer/fertilizer_calculation.dart';

class FertilizerCalculatorController extends GetxController {
  var selectedCrop = "".obs;
  var selectedUnit = "Acre".obs;
  var plotSize = 0.0.obs;
  var nitrogenController = TextEditingController();
  var phosphorusController = TextEditingController();
  var potassiumController = TextEditingController();
  var isLoading = false.obs; // For loading state
  var isCalculationDone = false.obs;
  var isCalculateButtonEnabled = false.obs;

  RxString nitrogen = "0".obs;
  RxString phosphorus = "0".obs;
  RxString potassium = "0".obs;

  // Constants for nutrient percentages
  static const double ureaN = 0.46; 
  static const double sspP = 0.16;
  static const double mopK = 0.60;

  // Standard bag weights
  static const double bagWeight = 50.0; // Adjust as needed
  
  // Initialize as RxDouble
  var mop = 0.0.obs; 
  var ssp = 0.0.obs;
  var urea = 0.0.obs;

  var mopBagsNeeded = 0.obs; 
  var sspBagsNeeded = 0.obs;
  var ureaBagsNeeded = 0.obs;

  void calculateFertilizer() {
    if (nitrogenController.text.isEmpty || phosphorusController.text.isEmpty || potassiumController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all nutrient values');
    } else {
      // Validation for numeric input
      final nitrogenValue = double.tryParse(nitrogenController.text);
      final phosphorusValue = double.tryParse(phosphorusController.text);
      final potassiumValue = double.tryParse(potassiumController.text);

      if (nitrogenValue == null || phosphorusValue == null || potassiumValue == null) {
        Get.snackbar('Error', 'Please enter valid numeric values');
      } else {
        isLoading(true); // Start loading
        try {
          double plotSizeInHa = THelperFunctions.convertUnits(plotSize.value, selectedUnit.value, 'Hector');

          // Calculations (using hectares)
          double calculatedN = nitrogenValue * plotSizeInHa;
          double calculatedP = phosphorusValue * plotSizeInHa;
          double calculatedK = potassiumValue * plotSizeInHa;

          double ureaNeeded = calculatedN / ureaN;
          double sspNeeded = calculatedP / sspP;
          double mopNeeded = calculatedK / mopK;

          int ureaBags = (ureaNeeded / bagWeight).ceil(); 
          int sspBags = (sspNeeded / bagWeight).ceil();
          int mopBags = (mopNeeded / bagWeight).ceil();

          // Update values of mop, ssp and urea with calculated results
          mop(mopNeeded);
          ssp(sspNeeded); 
          urea(ureaNeeded);

          mopBagsNeeded(mopBags);
          sspBagsNeeded(sspBags); 
          ureaBagsNeeded(mopBags);
          
          // After calculations are done
          debugPrint("Calculated Urea: ${urea.value}");
          debugPrint("Calculated SSP: ${ssp.value}");
          debugPrint("Calculated MOP: ${mop.value}");

          // Save to Hive
          calculateAndSave(
            nitrogenValue, 
            phosphorusValue,
            potassiumValue,
            ureaNeeded, 
            sspNeeded, 
            mopNeeded, 
            ureaBags, 
            sspBags, 
            mopBags
          );
          
          // Calculations complete
          isLoading(false);
          isCalculationDone(true);
        } catch (error) {
          isLoading(false);
          Get.snackbar('Error', 'Calculation failed: $error');
        }
      }
    }
  }

  void calculateAndSave(nitrogenValue, phosphorusValue, potassiumValue, double urea, double ssp, double mop, int ureaBags, int sspBags, int mopBags) {
    var box = Hive.box('calculations');
    box.add(FertilizerCalculation(
      cropType: selectedCrop.value,
      nitrogen: nitrogenValue,
      phosphorus: phosphorusValue,
      potassium: potassiumValue,
      unit: selectedUnit.value, 
      plotSize: plotSize.value,
      urea: urea,
      ssp: ssp,
      mop: mop,
      ureaBags: ureaBags,
      sspBags: sspBags,
      mopBags: mopBags, 
    ));
  }

  // Past Calculations (Assuming you have a list of FertilizerCalculation)
  List<FertilizerCalculation> pastCalculations = []; 

  void fetchPastCalculations() async {
    var box = await Hive.openBox('calculations');
    pastCalculations = box.values.cast<FertilizerCalculation>().toList();
    update(); // Force UI update
  }

  void resetNutrientQuantities() {
    // Reset nutrient quantities to default
    nitrogen.value = "0"; 
    phosphorus.value = "0";
    potassium.value = "0";
  }

  void saveNutrientQuantities() {
    nitrogen.value = nitrogenController.text;
    phosphorus.value = phosphorusController.text;
    potassium.value = potassiumController.text;

    // Optional step for calculation or database persistence after saving
    debugPrint("New Fertilizer Values:");
    debugPrint("Nitrogen: ${nitrogen.value}");
    debugPrint("Phosphorus: ${phosphorus.value}");
    debugPrint("Potassium: ${potassium.value}");
  }

  void incrementPlotSize() {
    plotSize.value++;
  }

  void decrementPlotSize() {
    plotSize.value--;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FertilizerController extends GetxController {
  // Rx variables for reactive updates
  RxString selectedCrop = ''.obs;
  RxString selectedUnit = 'Hector'.obs;
  final nController = TextEditingController();
  final kController = TextEditingController();
  final pController = TextEditingController();
  final plotSizeController = TextEditingController();
  final results = <String, double>{}.obs;
  final isFormValid = false.obs;

  // Temporary nutrient storage
  final tempN = 0.0.obs;
  final tempP = 0.0.obs;
  final tempK = 0.0.obs;

  // Crop Nutrient and Fertilizer Data (Initialized in the constructor)
  late final Map<String, Map<String, double>> cropNutrientRequirements;
  late final Map<String, double> fertilizerNutrientContent;

  @override
  void onInit() {
    super.onInit();
    // Initialize text controllers and listeners
    nController.addListener(checkFormValidity);
    kController.addListener(checkFormValidity);
    pController.addListener(checkFormValidity);
    plotSizeController.addListener(checkFormValidity);

    // Initialize data
    cropNutrientRequirements = {
      'Maize': {'N': 120, 'P': 60, 'K': 80},
      'Rice': {'N': 100, 'P': 50, 'K': 70},
      'Beans': {'N': 80, 'P': 40, 'K': 60},
      // Add more crops and their NPK requirements
    };
    fertilizerNutrientContent = {
      'MOP': 0.6, // 60% K20
      'SSP': 0.16, // 16% P205
      'Urea': 0.46, // 46% N
    };

    selectedCrop.value = cropNutrientRequirements.keys.first;
  }

  @override
  void dispose() {
    // Dispose of text controllers
    nController.dispose();
    kController.dispose();
    pController.dispose();
    plotSizeController.dispose();
    super.dispose();
  }

  // Fertilizer calculation function
  Map<String, double> calculationFertilizerAmounts(
      String crop, double n, double p, double k, String unit, double plotSize) {
    // Fetch nutrient requirements for the selected crop
    final cropRequirements = cropNutrientRequirements[crop];
    if (cropRequirements == null) {
      throw ArgumentError('Invalid crop selected');
    }

    // Calculate fertilizer amounts based on nutrient and plot size
    final mopAmount = (k * plotSize) / (fertilizerNutrientContent['MOP']! * 10); // kg/ha to kg
    final sspAmount = (p * plotSize) / (fertilizerNutrientContent['SSP']! * 10);
    final ureaAmount = (n * plotSize) / (fertilizerNutrientContent['Urea']! * 10);

    return {
      'MOP': mopAmount,
      'SSP': sspAmount,
      'Urea': ureaAmount,
    };
  }

  // Form Validation
  void checkFormValidity() {
    isFormValid.value = nController.text.isNotEmpty &&
        pController.text.isNotEmpty &&
        kController.text.isNotEmpty &&
        plotSizeController.text.isNotEmpty;
  }

  // Function to save temporary nutrients
  void saveTemporaryNutrients() {
    tempN.value = double.tryParse(nController.text) ?? 0.0;
    tempP.value = double.tryParse(pController.text) ?? 0.0;
    tempK.value = double.tryParse(kController.text) ?? 0.0;
  }

  // Calculate and Save
  Future<void> calculateAndSave() async {
    if (isFormValid.value) {
      final n = tempN.value != 0.0 ? tempN.value : double.parse(nController.text);
      final p = tempP.value != 0.0 ? tempP.value : double.parse(pController.text);
      final k = tempK.value != 0.0 ? tempK.value : double.parse(kController.text);

      results.value = calculationFertilizerAmounts(
        selectedCrop.value,
        n,
        p,
        k,
        selectedUnit.value,
        double.parse(plotSizeController.text),
      );
      await _saveData();

      // Clear temporary values after calculation
      tempN.value = 0.0;
      tempP.value = 0.0;
      tempK.value = 0.0;
    }
  }

  // Save Data to SQLite
  Future<void> _saveData() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'fertilizer_data.db');

    final database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS fertilizer_calculations (id INTEGER PRIMARY KEY AUTOINCREMENT, crop TEXT, n REAL, p REAL, k REAL, unit TEXT, plotSize REAL, mop REAL, ssp REAL, urea REAL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)',
        );
      },
      version: 1,
    );

    await database.insert('fertilizer_calculations', {
      'crop': selectedCrop.value,
      'n': double.parse(nController.text),
      'p': double.parse(pController.text),
      'k': double.parse(kController.text),
      'unit': selectedUnit.value,
      'plotSize': double.parse(plotSizeController.text),
      'mop': results['MOP'],
      'ssp': results['SSP'],
      'urea': results['Urea'],
    });
  }

  // Reset nutrient values
  void resetNutrients() {
    nController.clear();
    pController.clear();
    kController.clear();
  }

  // Increment plot size
  void incrementPlotSize() {
    final currentSize = double.tryParse(plotSizeController.text) ?? 0.0;
    plotSizeController.text = (currentSize + 1.0).toStringAsFixed(2); // Increment by 0.1
  }

  // Decrement plot size
  void decrementPlotSize() {
    final currentSize = double.tryParse(plotSizeController.text) ?? 0.0;
    if (currentSize > 0.1) {
      // Ensure plot size doesn't go below 0.1
      plotSizeController.text = (currentSize - 1.0).toStringAsFixed(2);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FertilizerController extends GetxController {
  // Rx variables for reactive updates
  var selectedCrop = "".obs;
  var selectedUnit = 'hectare'.obs;
  var nController = TextEditingController();
  var kController = TextEditingController();
  var pController = TextEditingController();
  var plotSizeController = TextEditingController();
  var results = RxMap<String, double?>();

  // Temporary nutrient storage
  var tempN = 0.0.obs;
  var tempP = 0.0.obs;
  var tempK = 0.0.obs;
  
  // Crop nutrient requirements (initialized in the constructor)
  late final Map<String, Map<String, double>> cropNutrientRequirements;

  // Fertilizer nutrient content (initialized in the constructor)
  late final Map<String, double> fertilizerNutrientContent;

  // Constructor
  FertilizerController() {
    // Crop nutrient requirements
    cropNutrientRequirements = {
      'Maize': {'N': 120, 'P': 60, 'K': 80},
      'Rice': {'N': 100, 'P': 50, 'K': 70},
      'Beans': {'N': 80, 'P': 40, 'K': 60},
      // Add more crops and their NPK requirements
    };

    // Fertilizer nutrient content
    fertilizerNutrientContent = {
      'MOP': 0.6, // 60% K20
      'SSP': 0.16, // 16% P205
      'Urea': 0.46, // 46% N
    };

    selectedCrop.value = cropNutrientRequirements.keys.first;
  }

  // Fertilizer calculation function
  Map<String, double> calculationFertilizerAmounts(
    String crop, double n, double p, double k, String unit, double plotSize
  ) {
    // Fetch nutrient requirements for the selected crop
    Map<String, double>? cropRequirements = cropNutrientRequirements[crop];
    if (cropRequirements == null) {
      throw ArgumentError('Invalid crop selected');
    }

    // Calculate fertilizer amounts based on nutrient and plot size
    double mopAmount = (k * plotSize) / (fertilizerNutrientContent['MOP']! * 10); // kg/ha to kg
    double sspAmount = (p * plotSize) / (fertilizerNutrientContent['SSP']! * 10);
    double ureaAmount = (n * plotSize) / (fertilizerNutrientContent['Urea']! * 10);

    return {
      'MOP': mopAmount,
      'SSP': sspAmount,
      'Urea': ureaAmount,
    };
  }

  // Function to save temporary nutrients
  void saveTemporaryNutrients() {
    tempN.value = double.tryParse(nController.text) ?? 0.0;
    tempP.value = double.tryParse(pController.text) ?? 0.0;
    tempK.value = double.tryParse(kController.text) ?? 0.0;
  }
  
  // Calculate and Save
  void calculateAndSave() {
    double n = tempN.value != 0.0 ? tempN.value : double.parse(nController.text);
    double p = tempP.value != 0.0 ? tempP.value : double.parse(pController.text);
    double k = tempK.value != 0.0 ? tempK.value : double.parse(kController.text);

    results.value = calculationFertilizerAmounts(
      selectedCrop.value,
      n,
      p,
      k,
      selectedUnit.value,
      double.parse(plotSizeController.text)
    );
    _saveData();

    // Clear temporary values after calculation
    tempN.value = 0.0;
    tempP.value = 0.0;
    tempK.value = 0.0;
  }

  Future<void> _saveData() async {
    // Get the database path within the app's documents directory
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'fertilizer_data.db');

    // Open or create the database at the specified path
    Database database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS fertilizer_calculations (id INTEGER PRIMARY KEY AUTOINCREMENT, crop TEXT, n REAL, p REAL, k REAL, unit TEXT, plotSize REAL, mop REAL, ssp REAL, urea REAL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)',
        );
      },
      version: 1,
    );

    // Insert data into the table
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

  // Additional methods for data retrieval and error handling
  Future<List<Map<String, dynamic>>> fetchCalculations() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'fertilizer_data.db');

    // Open the database
    final database = await openDatabase(path);

    // Query the table and return the results
    return await database.query('fertilizer_calculations');
  } 
  
  // Reset nutrient values
  void resetNutrients() {
    nController.clear(); 
    pController.clear();
    kController.clear();
  }

  // Increment plot size
  void incrementPlotSize() {
    double currentSize = double.tryParse(plotSizeController.text) ?? 0.0;
    plotSizeController.text = (currentSize + 1.0).toStringAsFixed(2); // Increament by 0.1
  }

  // Decrement plot size
  void decrementPlotSize() {
    double currentSize = double.tryParse(plotSizeController.text) ?? 0.0;
    if (currentSize > 0.1) {
      // Ensure plot size doesn't go below 0.1
      plotSizeController.text = (currentSize - 1.0).toStringAsFixed(2);
    }
  }
}
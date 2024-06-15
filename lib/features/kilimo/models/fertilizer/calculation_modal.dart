import 'package:cloud_firestore/cloud_firestore.dart';

class CalculationModal {
  final String id;
  final String cropType;
  final double nitrogen;
  final double phosphorus;
  final double potassium;
  final double plotSize;
  final String userId;
  final String userName;
  final double totalFertilizer;
  final DateTime date;

  // Constructor for CalculationModal
  CalculationModal({
    required this.id,
    required this.cropType,
    required this.nitrogen,
    required this.phosphorus,
    required this.potassium,
    required this.plotSize,
    required this.userId,
    required this.userName,
    required this.totalFertilizer,
    required this.date,
  });

  // static function to create an empty calculation modal
  static CalculationModal empty() => CalculationModal(
    id: '',
    cropType: '',
    nitrogen: 0.0,
    phosphorus: 0.0,
    potassium: 0.0,
    plotSize: 0.0,
    userId: '',
    userName: '',
    totalFertilizer: 0.0,
    date: DateTime.now(),
  );

  // Convert modal to JSON structure for storing data in firebase
  // toJson() - For Firestore serialization (No change needed)
  Map<String, dynamic> toJson() {
    return {
      'CropType': cropType,
      'Nitrogen': nitrogen,
      'Phosphorus': phosphorus,
      'Potassium': potassium,
      'PlotSize': plotSize,
      'UserId': userId,
      'UserName': userName,
      'TotalFertilizer': totalFertilizer,
      'Date': date,
    };
  }

  // Factory method to create a Calculation Modal from a Firebase document snapshot
  // fromSnapshot() - Now handles potential nulls more gracefully
  factory CalculationModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (!document.exists) {
      // Document doesn't exist, return empty Calculation Modal
      return CalculationModal.empty();
    }

    final data = document.data()!;

    return CalculationModal(
      id: document.id,
      cropType: data['CropType'] ?? '',
      nitrogen: data['Nitrogen'] ?? 0.0,
      phosphorus: data['Phosphorus'] ?? 0.0,
      potassium: data['Potassium'] ?? 0.0,
      plotSize: data['PlotSize'] ?? 0.0,
      userId: data['UserId'] ?? '',
      userName: data['UserName'] ?? '',
      totalFertilizer: data['TotalFertilizer'] ?? 0.0,
      // Parse date from Firestore Timestamp or use current time
      date: (data['Date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

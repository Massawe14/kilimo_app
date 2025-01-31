import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String? id;
  String userId;
  String phoneNumber;
  String cropType;
  List<String> predictionResult;
  String city;
  String district;
  String ward;
  DateTime date;

  Report({
    this.id,
    required this.userId,
    required this.phoneNumber,
    required this.cropType,
    required this.predictionResult,
    required this.city,
    required this.district,
    required this.ward,
    required this.date,
  });

  /// Create an empty report object
  static Report empty() => Report(
        userId: '',
        phoneNumber: '',
        cropType: '',
        predictionResult: [],
        city: '',
        district: '',
        ward: '',
        date: DateTime.now(),
      );

  /// Convert Firestore snapshot to `Report` object
  factory Report.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) return Report.empty();

    return Report(
      id: document.id,
      userId: data['userId'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      cropType: data['cropType'] ?? '',
      predictionResult: List<String>.from(data['predictionResult'] ?? []),
      city: data['city'] ?? '',
      district: data['district'] ?? '',
      ward: data['ward'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Convert `Report` object to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'cropType': cropType,
      'predictionResult': predictionResult,
      'city': city,
      'district': district,
      'ward': ward,
      'date': Timestamp.fromDate(date), // Ensure Firestore-compatible date
    };
  }
}

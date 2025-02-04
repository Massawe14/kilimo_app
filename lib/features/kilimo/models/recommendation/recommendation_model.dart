import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendationModel {
  final String id;
  final String name;
  final String userId;
  // List of symptoms
  final List<String> symptoms;
  // List of treatments
  final List<String> treatments;
  // List of preventive measures
  final List<String> preventiveMeasures;
  // Image
  final String image;
  final DateTime date;

  // Constructor for RecommendationModel
  RecommendationModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.symptoms,
    required this.treatments,
    required this.preventiveMeasures,
    required this.image,
    required this.date,
  });

  // static function to create an empty recommendation model
  static RecommendationModel empty() => RecommendationModel(
    id: '',
    name: '',
    userId: '',
    symptoms: [],
    treatments: [],
    preventiveMeasures: [],
    image: '',
    date: DateTime.now(),
  );

  // Convert modal to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'userId': userId,
    'symptoms': symptoms,
    'treatments': treatments,
    'preventiveMeasures': preventiveMeasures,
    'image': image,
    'date': date,
  };

  // Factory method to create an RecommendationModel from a JSON map
  factory RecommendationModel.fromJson(Map<String, dynamic> data, String documentId) {
    return RecommendationModel(
      id: documentId,
      name: data['name'] ?? '',
      userId: data['userId'] ?? '',
      symptoms: List<String>.from(data['symptoms'] ?? []),
      treatments: List<String>.from(data['treatments'] ?? []),
      preventiveMeasures: List<String>.from(data['preventiveMeasures'] ?? []),
      image: data['image'] ?? '',
      // Parse date from Firestore Timestamp or use current time
      date: (data['Date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Factory method to create an RecommendationModel from a Firestore document snapshot
  factory RecommendationModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    return RecommendationModel.fromJson(document.data() ?? {}, document.id);
  }
}

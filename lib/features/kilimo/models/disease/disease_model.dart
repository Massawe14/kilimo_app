import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseModal{
  final String id;
  final String name;
  final String symptoms;
  final String causes;
  final String treatment;

  DiseaseModal({
    required this.id,
    required this.name,
    required this.symptoms,
    required this.causes,
    required this.treatment,
  });

  // static function to create an empty disease modal
  static DiseaseModal empty() => DiseaseModal(
    id: '',
    name: '',
    symptoms: '',
    causes: '',
    treatment: '',
  );

  // Convert modal to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Symptoms': symptoms,
      'Causes': causes,
      'Treatment': treatment,
    };
  }

  // Factory method to create a DiseaseModal from a Firebase document snapshot
  factory DiseaseModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DiseaseModal(
        id: document.id,
        name: data['Name'] ?? '',
        symptoms: data['Symptoms'] ?? '',
        causes: data['Causes'] ?? '',
        treatment: data['Treatment'] ?? '',
      );
    } else {
      // Handle null case, for example, return an empty DiseaseModal
      return DiseaseModal.empty();
    }
  }
}

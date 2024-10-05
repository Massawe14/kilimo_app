import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseaseModal{
  final String id;
  final String name;
  final List<String> symptoms;
  final List<String> treatment;
  final List<String> preventiveMeasures;

  DiseaseModal({
    required this.id,
    required this.name,
    required this.symptoms,
    required this.treatment,
    required this.preventiveMeasures,
  });

  // static function to create an empty disease modal
  static DiseaseModal empty() => DiseaseModal(
    id: '',
    name: '',
    symptoms: [],
    treatment: [],
    preventiveMeasures: [],
  );

  // Convert modal to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Symptoms': jsonEncode(symptoms), // Encode list to JSON string
      'Treatment': jsonEncode(treatment), // Encode list to JSON string
      'Preventive_measures': jsonEncode(preventiveMeasures), // Encode list to JSON string
    };
  }

  // Factory method to create a DiseaseModal from a Firebase document snapshot
  factory DiseaseModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      debugPrint('Document data: $data'); // Log the raw data for debugging
      return DiseaseModal(
        id: document.id,
        name: data['Name'] ?? '',
        symptoms: List<String>.from(jsonDecode(data['Symptoms'] ?? '[]')),
        treatment: List<String>.from(jsonDecode(data['Treatment'] ?? '[]')),
        preventiveMeasures: List<String>.from(jsonDecode(data['Preventive_measures'] ?? '[]')),
      );
    } else {
      // Handle null case, for example, return an empty DiseaseModal
      return DiseaseModal.empty();
    }
  }

  @override
  String toString() {
    return 'DiseaseModal(id: $id, name: $name, symptoms: $symptoms, treatment: $treatment, preventive_measures: $preventiveMeasures)';
  }
}

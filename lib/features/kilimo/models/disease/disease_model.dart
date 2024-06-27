import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiseaseModal{
  final String id;
  final String name;
  final List<String> symptoms;
  final List<String> causes;
  final List<String> treatment;

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
    symptoms: [],
    causes: [],
    treatment: [],
  );

  // Convert modal to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Symptoms': jsonEncode(symptoms), // Encode list to JSON string
      'Causes': jsonEncode(causes), // Encode list to JSON string
      'Treatment': jsonEncode(treatment), // Encode list to JSON string
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
        causes: List<String>.from(jsonDecode(data['Causes'] ?? '[]')),
        treatment: List<String>.from(jsonDecode(data['Treatment'] ?? '[]')),
      );
    } else {
      // Handle null case, for example, return an empty DiseaseModal
      return DiseaseModal.empty();
    }
  }

  @override
  String toString() {
    return 'DiseaseModal(id: $id, name: $name, symptoms: $symptoms, causes: $causes, treatment: $treatment)';
  }
}

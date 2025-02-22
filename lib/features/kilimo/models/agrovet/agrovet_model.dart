import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../util/formatters/formatter.dart';

class AgrovetModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String country;
  final String state;
  final String city;
  final String district;
  final String ward;
  final DateTime date;

  // Constructor for AgrovetModel
  const AgrovetModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.country,
    required this.state,
    required this.city,
    required this.district,
    required this.ward,
    required this.date,
  });

  // Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // Static function to create an empty agrovet model
  static AgrovetModel empty() => AgrovetModel(
    id: '',
    name: '',
    phoneNumber: '',
    country: '',
    state: '',
    city: '',
    district: '',
    ward: '',
    date: DateTime.now(),
  );

  // Convert model to JSON structure for storing data in Firestore
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'country': country,
    'state': state,
    'city': city,
    'district': district,
    'ward': ward,
    'date': Timestamp.fromDate(date), // Convert DateTime to Firestore Timestamp
  };

  // Factory method to create an AgrovetModel from a JSON map
  factory AgrovetModel.fromJson(Map<String, dynamic> data, String documentId) {
    return AgrovetModel(
      id: documentId,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      country: data['country'] ?? '',
      state: data['state'] ?? '',
      city: data['city'] ?? '',
      district: data['district'] ?? '',
      ward: data['ward'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(), // Corrected key
    );
  }

  // Factory method to create an AgrovetModel from a Firestore document snapshot
  factory AgrovetModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    return AgrovetModel.fromJson(document.data() ?? {}, document.id);
  }

  // Override toString() for better debugging
  @override
  String toString() {
    return 'AgrovetModel{id: $id, name: $name, phoneNumber: $phoneNumber, country: $country, state: $state, city: $city, district: $district, ward: $ward, date: $date}';
  }
}

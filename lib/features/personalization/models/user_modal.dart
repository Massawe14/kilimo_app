// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../util/formatters/formatter.dart';

class UserModal { 
  // Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  final String street;
  final String city;
  final String state;
  final String country;
  final String district;
  final String userRole;
  String phoneNumber;
  String profilePicture;
  
  // Constructor for UserModel
  UserModal({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.userRole,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.district,
    required this.email,
    required this.profilePicture,
  });

  // Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  // Helper function to format phone number.
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // Helper function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Helper function to split full name into first and last name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  // static function to create an empty user modal
  static UserModal empty() => UserModal(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    country: '',
    district: '',
    userRole: '',
    profilePicture: '',
  );

  // Convert modal to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'Country': country,
      'District': district,
      'UserRole': userRole,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModal from a Firebase document snapshot
  factory UserModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModal(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        street: data['Street'] ?? '',
        city: data['City'] ?? '',
        state: data['State'] ?? '',
        country: data['Country'] ?? '',
        district: data['District'] ?? '',
        userRole: data['UserRole'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      // Handle null case, for example, return an empty UserModal
      return UserModal.empty();
    }
  }

  // Override toString() for better debugging
  @override
  String toString() {
    return 'UserModal(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phoneNumber: $phoneNumber, street: $street, city: $city, state: $state, country: $country, district: $district, userRole: $userRole, profilePicture: $profilePicture)';
  }
}

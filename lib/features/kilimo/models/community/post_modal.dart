import 'package:cloud_firestore/cloud_firestore.dart';

class PostModal {
  // Keep those values final which you do not want to update
  final String id;
  final String cropType;
  final String problemTitle;
  final String problemDescription;
  final String cropImage;
  final String userId;
  final String userName;
  final String userLocation;
  final DateTime date;

  // Constructor for PostModel
  PostModal({
    required this.id,
    required this.cropType,
    required this.problemTitle,
    required this.problemDescription,
    required this.cropImage,
    required this.userId,
    required this.userName,
    required this.userLocation,
    required this.date,
  });

  // static function to create an empty post modal
  static PostModal empty() => PostModal(
    id: '',
    cropType: '',
    problemTitle: '',
    problemDescription: '',
    cropImage: '',
    userId: '',
    userName: '',
    userLocation: '',
    date: DateTime.now(),
  );

  // Convert modal to JSON structure for storing data in firebase
  // toJson() - For Firestore serialization (No change needed)
  Map<String, dynamic> toJson() {
    return {
      'CropType': cropType,
      'ProblemTitle': problemTitle,
      'ProblemDescription': problemDescription,
      'CropImage': cropImage,
      'UserId': userId,
      'UserName': userName,
      'UserLocation': userLocation,
      'Date': date,
    };
  }

  // Factory method to create a PostModal from a Firebase document snapshot
  // fromSnapshot() - Now handles potential nulls more gracefully
  factory PostModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (!document.exists) {
      // Document doesn't exist, return empty PostModal
      return PostModal.empty();
    }

    final data = document.data()!;

    return PostModal(
      id: document.id,
      cropType: data['CropType'] ?? '',
      problemTitle: data['ProblemTitle'] ?? '',
      problemDescription: data['ProblemDescription'] ?? '',
      cropImage: data['CropImage'] ?? '',
      userId: data['UserId'] ?? '',
      userName: data['UserName'] ?? '',
      userLocation: data['UserLocation'] ?? '',
      // Parse date from Firestore Timestamp or use current time
      date: (data['Date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

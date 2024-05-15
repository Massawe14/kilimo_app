import 'package:cloud_firestore/cloud_firestore.dart';

class PostModal {
  // Keep those values final which you do not want to update
  final String id;
  final String cropType;
  final String problemTitle;
  final String problemDescription;
  final String cropImage;
  final String userId;
  late String userLocation;
  final DateTime date;

  // Constructor for PostModel
  PostModal({
    required this.id,
    required this.cropType,
    required this.problemTitle,
    required this.problemDescription,
    required this.cropImage,
    required this.userId,
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
    userLocation: '',
    date: DateTime.now(),
  );

  // Convert modal to JSON structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'CropType': cropType,
      'ProblemTitle': problemTitle,
      'ProblemDescription': problemDescription,
      'CropImage': cropImage,
      'UserId': userId,
      'UserLocation': userLocation,
      'Date': date,
    };
  }

  // Factory method to create a PostModal from a Firebase document snapshot
  factory PostModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return PostModal(
        id: document.id,
        cropType: data['CropType'] ?? '',
        problemTitle: data['ProblemTitle'] ?? '',
        problemDescription: data['ProblemDescription'] ?? '',
        cropImage: data['CropImage'] ?? '',
        userId: data['UserId'] ?? '',
        userLocation: data['UserLocation'] ?? '',
        date: DateTime.now(),
      );
    } else {
      // Handle null case, for example, return an empty PostModal
      return PostModal.empty();
    }
  }
}

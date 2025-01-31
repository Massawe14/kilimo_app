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
  final String profilePicture;
  final String userLocation;
  final DateTime date;
  final int likes;
  final int dislikes;
  final List<String> usersLiked;  // List of user IDs who liked the post
  final List<String> usersDisliked;  // List of user IDs who disliked the post

  // Constructor for PostModal
  PostModal({
    required this.id,
    required this.cropType,
    required this.problemTitle,
    required this.problemDescription,
    required this.cropImage,
    required this.userId,
    required this.userName,
    required this.profilePicture,
    required this.userLocation,
    required this.date,
    this.likes = 0,
    this.dislikes = 0,
    this.usersLiked = const [],
    this.usersDisliked = const [],
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
    profilePicture: '',
    userLocation: '',
    likes: 0,
    dislikes: 0,
    usersLiked: [],
    usersDisliked: [],
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
      'ProfilePicture': profilePicture,
      'UserLocation': userLocation,
      'Likes': likes,
      'Dislikes': dislikes,
      'UsersLiked': usersLiked,
      'UsersDisliked': usersDisliked,
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
      profilePicture: data['ProfilePicture'] ?? '',
      userLocation: data['UserLocation'] ?? '',
      likes: (data['Likes'] as int?) ?? 0,
      dislikes: (data['Dislikes'] as int?) ?? 0,
      usersLiked: List<String>.from(data['UsersLiked'] ?? []),
      usersDisliked: List<String>.from(data['UsersDisliked'] ?? []),
      // Parse date from Firestore Timestamp or use current time
      date: (data['Date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

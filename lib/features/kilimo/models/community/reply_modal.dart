import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyModal {
  // Keep those values final which you do not want to update
  final String id;
  final String replyText;
  final String userId;
  final String userName;
  final String profileImage;
  final DateTime date;

  // Constructor for ReplyModal
  ReplyModal({
    required this.id,
    required this.replyText,
    required this.userId,
    required this.userName,
    required this.profileImage,
    required this.date,
  });

  // static function to create an empty reply modal
  static ReplyModal empty() => ReplyModal(
    id: '',
    replyText: '',
    userId: '',
    userName: '',
    profileImage: '',
    date: DateTime.now(),
  );

  // Convert modal to JSON structure for storing data in firebase
  // toJson() - For Firestore serialization (No change needed)
  Map<String, dynamic> toJson() {
    return {
      'ReplyText': replyText,
      'UserId': userId,
      'UserName': userName,
      'ProfileImage': profileImage,
      'Date': date,
    };
  }

  // Factory method to create a ReplyModal from a Firebase document snapshot
  // fromSnapshot() - Now handles potential nulls more gracefully
  factory ReplyModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (!document.exists) {
      // Document doesn't exist, return empty PostModal
      return ReplyModal.empty();
    }

    final data = document.data()!;

    return ReplyModal(
      id: document.id,
      replyText: data['ReplyText'] ?? '',
      userId: data['UserId'] ?? '',
      userName: data['UserName'] ?? '',
      profileImage: data['ProfileImage'] ?? '',
      // Parse date from Firestore Timestamp or use current time
      date: (data['Date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FeedBackModal {
  // Keep those values final which you do not want to update
  final String id;
  final String feedBack;
  final String userId;
  final String userName;
  final DateTime date;

  // Constructor for FeedBackModal
  FeedBackModal({
    required this.id,
    required this.feedBack,
    required this.userId,
    required this.userName,
    required this.date,
  });

  // static function to create an empty post modal
  static FeedBackModal empty() => FeedBackModal(
    id: '',
    feedBack: '',
    userId: '',
    userName: '',
    date: DateTime.now(),
  );

  // Convert modal to JSON structure for storing data in firebase
  // toJson() - For Firestore serialization (No change needed)
  Map<String, dynamic> toJson() {
    return {
      'FeedBack': feedBack,
      'UserId': userId,
      'UserName': userName,
      'Date': date,
    };
  }

  // Factory method to create a FeedBackModal from a Firebase document snapshot
  // fromSnapshot() - Now handles potential nulls more gracefully
  factory FeedBackModal.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (!document.exists) {
      // Document doesn't exist, return empty FeedBackModal
      return FeedBackModal.empty();
    }

    final data = document.data()!;

    return FeedBackModal(
      id: document.id,
      feedBack: data['FeedBack'] ?? '',
      userId: data['UserId'] ?? '',
      userName: data['UserName'] ?? '',
      // Parse date from Firestore Timestamp or use current time
      date: (data['Date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

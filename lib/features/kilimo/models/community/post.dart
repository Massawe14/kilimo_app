import 'package:realm/realm.dart';

part 'post.realm.dart';

@RealmModel()
class _Post {
  @PrimaryKey()
  late ObjectId id;

  late String cropType;

  late String imageUrl;

  late String problemTitle;

  late String problemDescription;

  late String userId;

  late String userName;

  late String userLocation;

  late int upvotes;

  late int downvotes;

  late int replyCount;

  late String profileImage;

  late DateTime date;
}

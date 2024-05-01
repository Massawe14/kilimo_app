import 'package:realm/realm.dart';

part 'user.realm.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  late ObjectId id;

  late String userId;

  late String userName;

  late String profileImage;

  late String userLocation;

  late int upvotes;

  late int downvotes;

  late int replyCount;

  late DateTime date;
}

import 'package:realm/realm.dart';

part 'community.realm.dart';

@RealmModel()
class _Community {
  @PrimaryKey()
  late ObjectId id;

  late String crop;

  late String? image;

  late String problem;

  late String description;

  late String? location;

  late String? profileImage;

  late DateTime date;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Post extends _Post with RealmEntity, RealmObjectBase, RealmObject {
  Post(
    ObjectId id,
    String cropType,
    String imageUrl,
    String problemTitle,
    String problemDescription,
    String userId,
    String userName,
    String userLocation,
    int upvotes,
    int downvotes,
    int replyCount,
    String profileImage,
    DateTime date,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'cropType', cropType);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'problemTitle', problemTitle);
    RealmObjectBase.set(this, 'problemDescription', problemDescription);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userLocation', userLocation);
    RealmObjectBase.set(this, 'upvotes', upvotes);
    RealmObjectBase.set(this, 'downvotes', downvotes);
    RealmObjectBase.set(this, 'replyCount', replyCount);
    RealmObjectBase.set(this, 'profileImage', profileImage);
    RealmObjectBase.set(this, 'date', date);
  }

  Post._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get cropType =>
      RealmObjectBase.get<String>(this, 'cropType') as String;
  @override
  set cropType(String value) => RealmObjectBase.set(this, 'cropType', value);

  @override
  String get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String;
  @override
  set imageUrl(String value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String get problemTitle =>
      RealmObjectBase.get<String>(this, 'problemTitle') as String;
  @override
  set problemTitle(String value) =>
      RealmObjectBase.set(this, 'problemTitle', value);

  @override
  String get problemDescription =>
      RealmObjectBase.get<String>(this, 'problemDescription') as String;
  @override
  set problemDescription(String value) =>
      RealmObjectBase.set(this, 'problemDescription', value);

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String;
  @override
  set userName(String value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String get userLocation =>
      RealmObjectBase.get<String>(this, 'userLocation') as String;
  @override
  set userLocation(String value) =>
      RealmObjectBase.set(this, 'userLocation', value);

  @override
  int get upvotes => RealmObjectBase.get<int>(this, 'upvotes') as int;
  @override
  set upvotes(int value) => RealmObjectBase.set(this, 'upvotes', value);

  @override
  int get downvotes => RealmObjectBase.get<int>(this, 'downvotes') as int;
  @override
  set downvotes(int value) => RealmObjectBase.set(this, 'downvotes', value);

  @override
  int get replyCount => RealmObjectBase.get<int>(this, 'replyCount') as int;
  @override
  set replyCount(int value) => RealmObjectBase.set(this, 'replyCount', value);

  @override
  String get profileImage =>
      RealmObjectBase.get<String>(this, 'profileImage') as String;
  @override
  set profileImage(String value) =>
      RealmObjectBase.set(this, 'profileImage', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<Post>> get changes =>
      RealmObjectBase.getChanges<Post>(this);

  @override
  Post freeze() => RealmObjectBase.freezeObject<Post>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'cropType': cropType.toEJson(),
      'imageUrl': imageUrl.toEJson(),
      'problemTitle': problemTitle.toEJson(),
      'problemDescription': problemDescription.toEJson(),
      'userId': userId.toEJson(),
      'userName': userName.toEJson(),
      'userLocation': userLocation.toEJson(),
      'upvotes': upvotes.toEJson(),
      'downvotes': downvotes.toEJson(),
      'replyCount': replyCount.toEJson(),
      'profileImage': profileImage.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(Post value) => value.toEJson();
  static Post _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'cropType': EJsonValue cropType,
        'imageUrl': EJsonValue imageUrl,
        'problemTitle': EJsonValue problemTitle,
        'problemDescription': EJsonValue problemDescription,
        'userId': EJsonValue userId,
        'userName': EJsonValue userName,
        'userLocation': EJsonValue userLocation,
        'upvotes': EJsonValue upvotes,
        'downvotes': EJsonValue downvotes,
        'replyCount': EJsonValue replyCount,
        'profileImage': EJsonValue profileImage,
        'date': EJsonValue date,
      } =>
        Post(
          fromEJson(id),
          fromEJson(cropType),
          fromEJson(imageUrl),
          fromEJson(problemTitle),
          fromEJson(problemDescription),
          fromEJson(userId),
          fromEJson(userName),
          fromEJson(userLocation),
          fromEJson(upvotes),
          fromEJson(downvotes),
          fromEJson(replyCount),
          fromEJson(profileImage),
          fromEJson(date),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Post._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Post, 'Post', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('cropType', RealmPropertyType.string),
      SchemaProperty('imageUrl', RealmPropertyType.string),
      SchemaProperty('problemTitle', RealmPropertyType.string),
      SchemaProperty('problemDescription', RealmPropertyType.string),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('userLocation', RealmPropertyType.string),
      SchemaProperty('upvotes', RealmPropertyType.int),
      SchemaProperty('downvotes', RealmPropertyType.int),
      SchemaProperty('replyCount', RealmPropertyType.int),
      SchemaProperty('profileImage', RealmPropertyType.string),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

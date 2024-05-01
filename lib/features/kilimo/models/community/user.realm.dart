// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  User(
    ObjectId id,
    String userId,
    String userName,
    String profileImage,
    String userLocation,
    int upvotes,
    int downvotes,
    int replyCount,
    DateTime date,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'profileImage', profileImage);
    RealmObjectBase.set(this, 'userLocation', userLocation);
    RealmObjectBase.set(this, 'upvotes', upvotes);
    RealmObjectBase.set(this, 'downvotes', downvotes);
    RealmObjectBase.set(this, 'replyCount', replyCount);
    RealmObjectBase.set(this, 'date', date);
  }

  User._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

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
  String get profileImage =>
      RealmObjectBase.get<String>(this, 'profileImage') as String;
  @override
  set profileImage(String value) =>
      RealmObjectBase.set(this, 'profileImage', value);

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
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'userId': userId.toEJson(),
      'userName': userName.toEJson(),
      'profileImage': profileImage.toEJson(),
      'userLocation': userLocation.toEJson(),
      'upvotes': upvotes.toEJson(),
      'downvotes': downvotes.toEJson(),
      'replyCount': replyCount.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(User value) => value.toEJson();
  static User _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'userId': EJsonValue userId,
        'userName': EJsonValue userName,
        'profileImage': EJsonValue profileImage,
        'userLocation': EJsonValue userLocation,
        'upvotes': EJsonValue upvotes,
        'downvotes': EJsonValue downvotes,
        'replyCount': EJsonValue replyCount,
        'date': EJsonValue date,
      } =>
        User(
          fromEJson(id),
          fromEJson(userId),
          fromEJson(userName),
          fromEJson(profileImage),
          fromEJson(userLocation),
          fromEJson(upvotes),
          fromEJson(downvotes),
          fromEJson(replyCount),
          fromEJson(date),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(User._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('userName', RealmPropertyType.string),
      SchemaProperty('profileImage', RealmPropertyType.string),
      SchemaProperty('userLocation', RealmPropertyType.string),
      SchemaProperty('upvotes', RealmPropertyType.int),
      SchemaProperty('downvotes', RealmPropertyType.int),
      SchemaProperty('replyCount', RealmPropertyType.int),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

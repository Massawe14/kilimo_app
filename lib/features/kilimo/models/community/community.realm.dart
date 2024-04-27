// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Community extends _Community
    with RealmEntity, RealmObjectBase, RealmObject {
  Community(
    ObjectId id,
    String crop,
    String problem,
    String description,
    DateTime date, {
    String? image,
    String? location,
    String? profileImage,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'crop', crop);
    RealmObjectBase.set(this, 'image', image);
    RealmObjectBase.set(this, 'problem', problem);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'location', location);
    RealmObjectBase.set(this, 'profileImage', profileImage);
    RealmObjectBase.set(this, 'date', date);
  }

  Community._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get crop => RealmObjectBase.get<String>(this, 'crop') as String;
  @override
  set crop(String value) => RealmObjectBase.set(this, 'crop', value);

  @override
  String? get image => RealmObjectBase.get<String>(this, 'image') as String?;
  @override
  set image(String? value) => RealmObjectBase.set(this, 'image', value);

  @override
  String get problem => RealmObjectBase.get<String>(this, 'problem') as String;
  @override
  set problem(String value) => RealmObjectBase.set(this, 'problem', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get location =>
      RealmObjectBase.get<String>(this, 'location') as String?;
  @override
  set location(String? value) => RealmObjectBase.set(this, 'location', value);

  @override
  String? get profileImage =>
      RealmObjectBase.get<String>(this, 'profileImage') as String?;
  @override
  set profileImage(String? value) =>
      RealmObjectBase.set(this, 'profileImage', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<Community>> get changes =>
      RealmObjectBase.getChanges<Community>(this);

  @override
  Community freeze() => RealmObjectBase.freezeObject<Community>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'crop': crop.toEJson(),
      'image': image.toEJson(),
      'problem': problem.toEJson(),
      'description': description.toEJson(),
      'location': location.toEJson(),
      'profileImage': profileImage.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(Community value) => value.toEJson();
  static Community _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'crop': EJsonValue crop,
        'image': EJsonValue image,
        'problem': EJsonValue problem,
        'description': EJsonValue description,
        'location': EJsonValue location,
        'profileImage': EJsonValue profileImage,
        'date': EJsonValue date,
      } =>
        Community(
          fromEJson(id),
          fromEJson(crop),
          fromEJson(problem),
          fromEJson(description),
          fromEJson(date),
          image: fromEJson(image),
          location: fromEJson(location),
          profileImage: fromEJson(profileImage),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Community._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Community, 'Community', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('crop', RealmPropertyType.string),
      SchemaProperty('image', RealmPropertyType.string, optional: true),
      SchemaProperty('problem', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('location', RealmPropertyType.string, optional: true),
      SchemaProperty('profileImage', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

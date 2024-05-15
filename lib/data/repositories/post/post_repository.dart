import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/models/community/post_modal.dart';
import '../../../util/exceptions/firebase_exceptions.dart';
import '../../../util/exceptions/format_exceptions.dart';
import '../../../util/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repository.dart';

class PostRepository extends GetxController {
  static PostRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to save post data to Firestore
  Future<void> savePostRecord(PostModal post) async {
    try {
      await _db.collection("Posts").doc(post.id).set(post.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Function to fetch post details based on user ID.
  Future<PostModal> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection("Posts").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return PostModal.fromSnapshot(documentSnapshot);
      } else {
        return PostModal.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}

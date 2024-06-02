import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/models/community/post_modal.dart';
import '../../../util/exceptions/firebase_exceptions.dart';

class PostRepository extends GetxController {
  static PostRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAllPosts();
  }

  // Save Post Record
  Future<void> savePostRecord(PostModal post) async {
    try {
      await _db.collection("Posts").doc(post.id).set(post.toJson());
    } on FirebaseException catch (e) {
      // Handle Firebase-specific errors directly
      throw TFirebaseException(e.code).message;
    } catch (e) {
      // Catch and rethrow any other exceptions for higher-level handling
      throw Exception('Error saving post: $e');
    }
  }

  // Fetch Posts By ID (QuerySnapshot)
  Future<QuerySnapshot<Map<String, dynamic>>> fetchPostsByPostId(String postId) async {
    return await _db.collection("Posts")
      .where('UserId', isEqualTo: postId)
      .get();
  }

  // Fetch Posts By User ID (QuerySnapshot)
  Future<QuerySnapshot<Map<String, dynamic>>> fetchPostsByUserId(String userId) async {
    return await _db.collection("Posts")
      .where('UserId', isEqualTo: userId)
      .orderBy('Date', descending: true)
      .get();
  }

  // Fetch Posts By Location (QuerySnapshot)
  Future<QuerySnapshot<Map<String, dynamic>>> fetchPostsByLocation(String location) async {
    return await _db.collection("Posts")
      .where('UserLocation', isEqualTo: location)
      .orderBy('Date', descending: true)
      .get();
  }

  // Fetch Filtered Posts (QuerySnapshot)
  Future<QuerySnapshot<Map<String, dynamic>>> fetchFilteredPosts(String filter, String location) async {
    Query<Map<String, dynamic>> query = _db.collection("Posts");

    if (filter != 'All') {
      query = query.where('CropType', isEqualTo: filter);
    }

    if (location.isNotEmpty) {
      query = query.where('UserLocation', isEqualTo: location);
    }

    return await query
      .orderBy('Date', descending: true)
      .get();
  }

  // Fetch All Posts (QuerySnapshot)
  Future<QuerySnapshot<Map<String, dynamic>>> fetchAllPosts() async {
    return await _db.collection("Posts")
      .orderBy('Date', descending: true)
      .get();
  }

  // Delete Post by ID
  Future<void> deletePost(String postId) async {
    try {
      await _db.collection("Posts").doc(postId).delete();
    } catch (e) {
      throw Exception('Error deleting post: $e');
    }
  }

  // Search Posts
  Future<List<PostModal>> searchPosts(String query) async {
    final snapshot = await _db.collection("Posts")
      .where('searchIndex', arrayContains: query.toLowerCase())
      .get();
    final posts = snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList();
    debugPrint('Searched posts with query ($query): $posts');
    return posts;
  }
}

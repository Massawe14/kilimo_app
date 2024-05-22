import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/kilimo/models/community/post_modal.dart';
import '../../../util/exceptions/firebase_exceptions.dart';

class PostRepository extends GetxController {
  static PostRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final posts = <PostModal>[].obs; // Observables list for UI updates
  List<String> get cropTypes => posts.map((post) => post.cropType).toSet().toList();

  @override
  void onInit() {
    super.onInit();
    fetchAllPosts().listen((posts) { // Listen to changes and update list
      this.posts.value = posts;
    });
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

  // Fetch Posts By User ID (Stream)
  Stream<List<PostModal>> fetchPostsByUserId(String userId) {
    return _db.collection("Posts")
      .where('userId', isEqualTo: userId)
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList());
  }

  // Fetch Posts By Location (Stream)
  Stream<List<PostModal>> fetchPostsByLocation(String location) {
    return _db.collection("Posts")
      .where('userLocation', isEqualTo: location)
      .orderBy('date', descending: true) // Sort by date (newest first)
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList());
  }

  // Fetch Filtered Posts (Stream)
  Stream<List<PostModal>> fetchFilteredPosts(String filter, String location) {
    Query<Map<String, dynamic>> query = _db.collection("Posts");

    if (filter != 'All') {
      query = query.where('cropType', isEqualTo: filter);
    }

    if (location.isNotEmpty) {
      query = query.where('userLocation', isEqualTo: location);
    }

    return query
      .orderBy('date', descending: true) // Sort by date (newest first)
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList());
  }

  // Fetch All Posts (Stream)
  Stream<List<PostModal>> fetchAllPosts() {
    return _db.collection("Posts")
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshot) =>
        snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList());
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
    return snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList();
  }
}

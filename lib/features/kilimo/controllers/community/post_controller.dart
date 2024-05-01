import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../../models/community/post.dart';

class PostController extends GetxController {
  // Create a Configuration object
  final config = Configuration.local([Post.schema]);
  
  RxList<Post> posts = <Post>[].obs;
  final isLoading = false.obs; 

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  void _fetchData() async {
    // Set isLoading to true before fetching
    isLoading.value = true;

    // Open a Realm
    final realm = Realm(config);

    try {
      var results = realm.all<Post>();
      posts.value = results.toList();
    } on RealmException catch (e) {
      // Handle Realm specific errors
      debugPrint("Error fetching posts: $e");
    } finally {
      // Close the realm
      realm.close();

      // Set isLoading to false after fetching (success or error)
      isLoading.value = false;
    } 
  }
}

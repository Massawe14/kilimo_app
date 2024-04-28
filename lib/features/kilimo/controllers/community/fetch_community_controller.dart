import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../../../../util/helpers/helper_functions.dart';
import '../../models/community/community.dart';

class CommunityPostsController extends GetxController {
  RxList <Community> communityPosts = <Community>[].obs;

  void fetchCommunityPosts(Community currentPost) async {
    // Create a Configuration object
    var config = Configuration.local([Community.schema]);

    // Open a Realm
    var realm = Realm(config);
    
    try {
      // Get all objects of type
      var allPosts = realm.all<Community>().toList();

      // Sort the posts by date
      allPosts.sort((a, b) => b.date.compareTo(a.date));

      // Filter posts to exclude the current post
      var filteredPosts = allPosts.where((post) => post.id != currentPost.id).toList();

      // Update communityPosts with filtered posts
      communityPosts.assignAll(filteredPosts);
    } catch (e) {
      debugPrint('Error reading data: $e');
      THelperFunctions.showSnackBar('Failed to read data. Please try again.');
    } finally {
      // Close the realm
      realm.close();
    }
  }
}

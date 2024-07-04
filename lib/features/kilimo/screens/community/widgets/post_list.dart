import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/post/post_repository.dart';
import '../../../../../util/constants/colors.dart';
import '../../../../../util/helpers/helper_functions.dart';
import '../../../models/community/post_modal.dart';
import '../reply_community_screen.dart';
import 'question_card.dart';

class TPostList extends StatelessWidget {
  TPostList({
    super.key,
    required this.filter, 
    required this.searchQuery,
  });

  final String filter;
  final String searchQuery;

  final PostRepository postRepository = Get.put(PostRepository());

  Future<List<PostModal>> getPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (filter == 'All' && searchQuery.isEmpty) {
      snapshot = await postRepository.fetchAllPosts();
    } else if (filter == 'All') {
      snapshot = await postRepository.fetchPostsByLocation(searchQuery);
    } else {
      snapshot = await postRepository.fetchFilteredPosts(filter, searchQuery);
    }
    return snapshot.docs.map((doc) => PostModal.fromSnapshot(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return FutureBuilder<List<PostModal>>(
      future: getPosts(),
      builder: (context, AsyncSnapshot<List<PostModal>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: darkMode ? TColors.white : TColors.black,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return SliverToBoxAdapter(
            child: Center(
              child: Text('error: ${snapshot.error}'.tr),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint('No data: ${snapshot.data}');
          return SliverToBoxAdapter(
            child: Center(
              child: Text('no_data'.tr)
            ),
          );
        } else {
          final posts = snapshot.data!;
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = posts[index]; // Use the filtered list
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ReplyCommunityScreen(postId: post.id));
                  },
                  child: TQuestionCard(
                    image: post.cropImage, // Assuming cropImage is the field name
                    username: post.userName,
                    profilePicture: post.profilePicture,
                    userId: post.userId,
                    location: post.userLocation,
                    crop: post.cropType,
                    date: post.date,
                    title: post.problemTitle,
                    description: post.problemDescription,
                  ),
                );
              },
              childCount: posts.length,
            ),
          );
        }
      },
    );
  }
}

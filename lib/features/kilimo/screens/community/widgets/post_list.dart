import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/post/post_repository.dart';
import '../../../models/community/post_modal.dart';
import '../reply_community_screen.dart';
import 'question_card.dart';

class TPostList extends StatelessWidget {
  const TPostList({
    super.key,
    required this.filter, 
    required this.searchQuery,
  });

  final String filter;
  final String searchQuery;

  Future<QuerySnapshot<Map<String, dynamic>>> getPostsQuery() {
    final PostRepository postRepository = Get.find<PostRepository>();

    if (filter == 'All' && searchQuery.isEmpty) {
      return postRepository.fetchAllPosts();
    } else if (filter == 'All') {
      return postRepository.fetchPostsByLocation(searchQuery);
    } else {
      return postRepository.fetchFilteredPosts(filter, searchQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: getPostsQuery(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          debugPrint('No data: ${snapshot.data}');
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('No community posts available')
            ),
          );
        } else {
          final posts = snapshot.data!.docs
            .map((doc) => PostModal.fromSnapshot(doc))
            .toList();
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = posts[index]; // Use the filtered list
                return GestureDetector(
                  onTap: () => Get.to(ReplyCommunityScreen(postId: post.id)),
                  child: TQuestionCard(
                    image: post.cropImage, // Assuming cropImage is the field name
                    username: post.userName,
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

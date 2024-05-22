import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/post/post_repository.dart';
import '../../../models/community/post_modal.dart';
import 'question_card.dart';

class TCropList extends StatelessWidget {
  const TCropList({
    super.key,
    required this.filter, 
    required this.searchQuery,
  });

  final String filter;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final PostRepository postRepository = Get.put(PostRepository()); // Get the existing instance

    return StreamBuilder<List<PostModal>>(
      stream: filter == 'All' && searchQuery.isEmpty 
        ? postRepository.fetchAllPosts() 
        : filter == 'All' 
          ? postRepository.fetchPostsByLocation(searchQuery)
          : postRepository.fetchFilteredPosts(filter, searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('No community posts available')
            ),
          );
        } else {
          final posts = snapshot.data!;
          final filteredPosts = posts.where((post) {
            final matchesCrop = filter == 'All' || post.cropType == filter;
            final matchesLocation = searchQuery.isEmpty || post.userLocation.toLowerCase().contains(searchQuery.toLowerCase());
            return matchesCrop && matchesLocation;
          }).toList();

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final post = filteredPosts[index]; // Use the filtered list
                return TQuestionCard(
                  image: post.cropImage, // Assuming cropImage is the field name
                  username: post.userName,
                  location: post.userLocation,
                  crop: post.cropType,
                  date: post.date,
                  title: post.problemTitle,
                  description: post.problemDescription,
                );
              },
              childCount: filteredPosts.length,
            ),
          );
        }
      },
    );
  }
}

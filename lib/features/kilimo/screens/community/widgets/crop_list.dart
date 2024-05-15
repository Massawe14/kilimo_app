import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/community/post_controller.dart';
import 'question_card.dart';

class TCropList extends StatelessWidget {
  const TCropList({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());
    return Obx(() {
      if (controller.isLoading.value) { 
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      } else if (controller.posts.isNotEmpty) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Text('No community posts available'),
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = controller.posts[index];
              return TQuestionCard(
                image: post.imageUrl,
                username: post.userName,
                location: post.userLocation,
                crop: post.cropType,
                date: post.date,
                title: post.problemTitle,
                description: post.problemDescription,
              );
            },
            childCount: controller.posts.length,
          ),
        );
      }
    });
  }
}

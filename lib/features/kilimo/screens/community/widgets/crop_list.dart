import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/community/fetch_community_controller.dart';
import 'question_card.dart';

class TCropList extends StatelessWidget {
  const TCropList({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityPostsController controller = Get.put(CommunityPostsController());
    return Obx(() {
      if (controller.communityPosts.isEmpty) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Text('No community posts available'),
          ),
        );
      } else {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = controller.communityPosts[index];
              return TQuestionCard(
                image: '${post.image}',
                title: post.problem,
                description: post.description,
              );
            },
            childCount: controller.communityPosts.length,
          ),
        );
      }
    });
  }
}

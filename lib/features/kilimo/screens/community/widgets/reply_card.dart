import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../common/widgets/image_text_widget/t_circular_image.dart';
import '../../../../../util/constants/image_strings.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../controllers/community/post_community_controller.dart';
import '../../../models/community/reply_modal.dart';

class TReplyCard extends StatelessWidget {
  const TReplyCard({
    super.key,
    required this.postController,
    required this.postId,
  });

  final PostCommunityController postController;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: postController.getRepliesStream(postId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('something_went_wrong'.tr),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: const SizedBox(),
          );
        }
    
        List<ReplyModal> replies = snapshot.data!.docs.map((doc) {
          return ReplyModal.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>);
        }).toList();
    
        return ListView.builder(
          shrinkWrap: true,
          itemCount: replies.length,
          itemBuilder: (context, index) {
            final reply = replies[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TCircularImage(
                      image: reply.profileImage.isNotEmpty ? reply.profileImage : TImages.profileImage, 
                      width: 56, 
                      height: 56, 
                      isNetworkImage: reply.profileImage.isNotEmpty,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reply.userName),
                        const SizedBox(height: 3),
                        Text(timeago.format(reply.date)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  reply.replyText, 
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
              ],
            );
          },
        );
      },
    );
  }
}

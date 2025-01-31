import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../common/widgets/image_text_widget/t_circular_image.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../controllers/community/post_community_controller.dart';
import '../../controllers/community/share_post_controller.dart';
import 'widgets/reply_card.dart';
import 'widgets/reply_community_appbar.dart';

class ReplyCommunityScreen extends StatelessWidget {
  const ReplyCommunityScreen({
    super.key, 
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    final shareController = Get.put(SharePostController());
    final PostCommunityController postController = Get.put(PostCommunityController());

    // Fetch post details when the screen is loaded
    postController.fetchPostDetails(postId);

    return Scaffold(
      body: Obx(() {
        final post = postController.selectedPost.value;
        return SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              ReplyCommunityAppBar(image: post.cropImage),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: TCircularImage(
                              image: post.profilePicture.isNotEmpty ? post.profilePicture : TImages.profileImage, 
                              width: 56, 
                              height: 56, 
                              isNetworkImage: post.profilePicture.isNotEmpty,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // User Information
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            post.userName,
                            style: const TextStyle(
                              color: TColors.accent,
                              fontSize: TSizes.fontSizeMd,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          // Location & Date
                          const SizedBox(width: 5),
                          const Text(
                            '.',
                            style: TextStyle(
                              color: TColors.darkGrey,
                              fontSize: TSizes.fontSizeSm,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            post.userLocation,
                            style: const TextStyle(
                              color: TColors.darkGrey,
                              fontSize: TSizes.fontSizeSm,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            timeago.format(post.date),
                            style: const TextStyle(
                              color: TColors.darkGrey,
                              fontSize: TSizes.fontSizeSm,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '.',
                            style: TextStyle(
                              color: TColors.darkGrey,
                              fontSize: TSizes.fontSizeSm,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            post.cropType,
                            style: const TextStyle(
                              color: TColors.darkGrey,
                              fontSize: TSizes.fontSizeSm,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(TSizes.spaceBtwItems),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.problemTitle,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.problemDescription,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: TColors.grey),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: postController.isLiked.value 
                                        ? Icon(Iconsax.like_1, color: Colors.blue) 
                                        : Icon(Iconsax.like_1, color: TColors.darkGrey),
                                      onPressed: () => postController.likePost(postId),
                                    ),
                                    Text(
                                      postController.likes.value.toString(),
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: postController.isDisliked.value 
                                        ? Icon(Iconsax.dislike, color: TColors.error) 
                                        : Icon(Iconsax.dislike, color: TColors.darkGrey),
                                      onPressed: () => postController.dislikePost(postId),
                                    ),
                                    Text(
                                      postController.dislikes.value.toString(),
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {
                              // Use ShareController to share product details
                              shareController.sharePostDetails(
                                image: post.cropImage,
                                title: post.problemTitle,
                                description: post.problemDescription,
                              );
                            }, 
                          ),
                        ],
                      ),
                      const Divider(color: TColors.grey),
                      // Display the Replies here
                      TReplyCard(
                        postController: postController, 
                        postId: postId
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: TSizes.defaultSpace, right: TSizes.defaultSpace),
        child: TextField(
          expands: false,
          controller: postController.replyController,
          decoration: InputDecoration(
            hintText: 'reply_hint'.tr,
            labelText: 'reply_label'.tr,
            prefixIcon: IconButton(
              icon: const Icon(Iconsax.attach_circle),
              onPressed: () {},
            ),
            suffixIcon: IconButton(
              icon: const Icon(Iconsax.send_1),
              onPressed: () => postController.addReply(postId),
            ),
          ),
          maxLength: 200,
        ),
      ),
    );
  }
}

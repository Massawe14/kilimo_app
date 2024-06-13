import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../common/widgets/image_text_widget/t_circular_image.dart';
import '../../../../common/widgets/loaders/shimmer.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/constants/sizes.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../controllers/community/post_community_controller.dart';
import 'widgets/reply_community_appbar.dart';

class ReplyCommunityScreen extends StatelessWidget {
  const ReplyCommunityScreen({
    super.key, 
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
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
                            child: Obx(() {
                              final networkImage = userController.user.value.profilePicture;
                              final image = networkImage.isNotEmpty ? networkImage : TImages.profileImage;
                              return userController.imageUploading.value
                                ? const TShimmerEffect(
                                    width: 80, 
                                    height: 80, 
                                    radius: 80
                                  )
                                : TCircularImage(
                                    image: image, 
                                    width: 56, 
                                    height: 56, 
                                    isNetworkImage: networkImage.isNotEmpty,
                                  );
                            }),
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
                          IconButton(
                            icon: const Icon(Iconsax.like_1),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.dislike),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
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
          decoration: InputDecoration(
            hintText: 'Reply...',
            labelText: 'Write your reply',
            suffixIcon: IconButton(
              icon: const Icon(Iconsax.send_1),
              onPressed: () async {
                final replyText = TextEditingController().text.trim();
                if (replyText.isNotEmpty) {
                  await postController.addReply(postId, replyText);
                  TextEditingController().clear();
                  // Optionally show a success message
                  Get.snackbar(
                    'Success',
                    'Reply added successfully',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  // Show an error if the reply text is empty
                  Get.snackbar(
                    'Error',
                    'Reply cannot be empty',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ),
          maxLength: 1200,
        ),
      ),
    );
  }
}
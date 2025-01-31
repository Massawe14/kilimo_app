import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../common/widgets/image_text_widget/t_circular_image.dart';
import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/image_strings.dart';
import '../../../../../util/constants/sizes.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../controllers/community/post_community_controller.dart';
import '../../../controllers/community/share_post_controller.dart';

class TQuestionCard extends StatelessWidget {
  const TQuestionCard({
    super.key,
    required this.postId,
    required this.image,
    required this.username,
    required this.profilePicture,
    required this.userId,
    required this.location,
    required this.crop,
    required this.title,
    required this.description,
    required this.date,
    required this.likes,
    required this.dislikes,
  });

  final String image, username, userId, location, crop, postId;
  final String title, profilePicture;
  final String description;
  final int likes, dislikes;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    // Access the ShareController
    final shareController = Get.put(SharePostController());
    final postController = Get.put(PostCommunityController());
    final controller = Get.put(UserController());
    controller.fetchUserRecordById(userId); // Call function here

    // Display the post card UI
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(128),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image (Using CachedNetworkImage)
            CachedNetworkImage(
              imageUrl: image,
              errorWidget: (context, url, error) => const Icon(Icons.error), // Error icon
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: TCircularImage(
                    image: profilePicture.isNotEmpty ? profilePicture : TImages.profileImage, 
                    width: 70, 
                    height: 70, 
                    isNetworkImage: profilePicture.isNotEmpty,
                  ),
                ),
                const SizedBox(width: 12),
                // User Information
                Expanded( // Make the column take available space
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              username,
                              style: const TextStyle(
                                color: TColors.accent,
                                fontSize: TSizes.fontSizeMd,
                                fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
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
                            location,
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
                            timeago.format(date),
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
                            crop,
                            style: const TextStyle(
                              color: TColors.darkGrey,
                              fontSize: TSizes.fontSizeSm,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
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
                      image: image,
                      title: title,
                      description: description,
                    );
                  }, 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

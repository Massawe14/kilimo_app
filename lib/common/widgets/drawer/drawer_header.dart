import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../features/personalization/screens/profile/profile_screen.dart';
import '../../../util/constants/colors.dart';
import '../../../util/constants/image_strings.dart';
import '../loaders/shimmer.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Material(
      color: TColors.green,
      child: InkWell(
        onTap: () {
          // Close navigation drawer before
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProfileScreen())
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage(TImages.profileImage),
              ),
              const SizedBox(height: 12),
              Obx(
                () {
                  if (controller.profileLoading.value) {
                    // Display a shimmer loader while user profile is being loaded
                    return const TShimmerEffect(width: 80, height: 15);
                  } else {
                    return Text(controller.user.value.lastName, style: const TextStyle(color: TColors.white, fontSize: 28));
                  }
                }
              ),
              Obx(
                () {
                  if (controller.profileLoading.value) {
                    // Display a shimmer loader while user profile is being loaded
                    return const TShimmerEffect(width: 80, height: 15);
                  } else {
                    return Text(controller.user.value.email, style: const TextStyle(color: TColors.white, fontSize: 16));
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

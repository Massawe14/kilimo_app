import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/repositories/post/post_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../util/constants/image_strings.dart';
import '../../../../util/helpers/network_manager.dart';
import '../../../../util/popups/full_screen_loader.dart';
import '../../../../util/popups/loaders.dart';
import '../../models/community/post_modal.dart';

class PostCommunityController extends GetxController {
  static PostCommunityController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  final postRepository = Get.put(PostRepository());
  
  final selectedCrop = '';
  final problemTitle = TextEditingController();
  final problemDescription = TextEditingController();
  final uid = const Uuid().v4();

  Future<void> savePostRecord() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information', TImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }
      
      // Fetch user details
      final user = await userRepository.fetchUserDetails();

      // Get user's current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      String userLocation = '${position.latitude}, ${position.longitude}';

      if (user.id.isEmpty) {
        // Map Data
        final post = PostModal(
          id: uid,
          cropType: selectedCrop,
          problemTitle: problemTitle.text.trim(),
          problemDescription: problemDescription.text.trim(),
          cropImage: "",
          userId: user.id,
          userLocation: userLocation,
          date: DateTime.now(),
        );

        // Save user data
        await postRepository.savePostRecord(post);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Post not sent',
        message: 'Something went wrong posting your problem. You can re-post your post in your community',
      );
    }
  }
}

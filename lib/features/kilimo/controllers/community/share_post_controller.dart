import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class SharePostController extends GetxController {
  /// Shares post details with other apps.
  void sharePostDetails({
    required String title,
    required String description,
    required String image,
  }) {
    // Construct the share message
    final message = """
      Check out this post:
      Image: $image
      Title: $title
      Description: $description
    """;

    // Share the message using share_plus
    Share.share(message);
  }
}

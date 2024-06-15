import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kilimo_app/common/widgets/loaders/shimmer.dart';

import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';
import '../../../util/helpers/helper_functions.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
  });

  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ??
          (THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width / 2), // Ensure radius is half of width for a perfect circle
        child: isNetworkImage
          ? CachedNetworkImage(
              imageUrl: image,
              fit: fit,
              placeholder: (context, url) => const TShimmerEffect(width: 55, height: 55, radius: 55),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Image.asset(
              image,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
      ),
    );
  }
}

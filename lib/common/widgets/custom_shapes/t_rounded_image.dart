import 'package:flutter/material.dart';
import 'package:kilimo_app/util/constants/colors.dart';

import '../../../util/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key, 
    this.width, 
    this.height, 
    required this.imageurl, 
    this.applyImageRadius = true, 
    this.border, 
    this.backgroundColor = TColors.light, 
    this.fit = BoxFit.contain, 
    this.padding, 
    this.isNetworkImage = false,  
    this.onPressed, 
    this.borderRadius = TSizes.md,
  });

  final double? width, height;
  final String imageurl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: Image(fit: fit, image: isNetworkImage ? NetworkImage(imageurl) : AssetImage(imageurl) as ImageProvider),
        ),
      ),
    );
  }
}
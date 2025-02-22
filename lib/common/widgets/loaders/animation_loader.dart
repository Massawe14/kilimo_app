import 'package:flutter/material.dart';

import '../../../util/constants/colors.dart';
import '../../../util/constants/sizes.dart';

// A widget for displaying on animated loading with optional text and action button
class TAnimationLoaderWidget extends StatelessWidget {
  // Default constructor for the TAnimationLoaderWidget.
  // Parameters:
  //   - text: The text to be displayed below the animation
  //   - animation: The path to the lottie animation file.
  //   - showAction: Whether to show an action button below the text.
  //   - actionText: The text to be displayed on the action button.
  //   - onActionPressed: Callback function to be excuted when the action button is pressed.
  const TAnimationLoaderWidget({
    super.key, 
    required this.text, 
    required this.animation, 
    this.showAction = false, 
    this.actionText, 
    this.onActionPressed,
    this.height,
    this.width,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Load GIF animation
          Image.asset(animation, height: height ?? MediaQuery.of(context).size.height * 0.5, width: width ?? MediaQuery.of(context).size.width * 0.8),
          const SizedBox(height: TSizes.defaultSpace),
          Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: TSizes.defaultSpace),
          // Conditional rendering of the action button
          showAction
            ? SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                  style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
                  child: Text(
                    actionText!,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light),
                  ),
                ),
              )
            : const SizedBox(),
          ],
      ),
    );
  }
}

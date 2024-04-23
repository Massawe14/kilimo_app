import 'package:flutter/material.dart';

import '../../../../../util/constants/colors.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  AnimatedButtonState createState() => AnimatedButtonState();
}

class AnimatedButtonState extends State<AnimatedButton> {
  Color _buttonColor = TColors.darkGrey;
  Color _textColor = TColors.info;
  late final String title;

  void _changeColor() {
    setState(() {
      if (_buttonColor == Colors.grey) {
        _buttonColor = Colors.blue;
        _textColor = Colors.white;
      } else {
        _buttonColor = Colors.grey;
        _textColor = Colors.blue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changeColor();
        widget.onPressed();
      },
      child: Container(
        width: 100,
        height: 50,
        color: _buttonColor,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: _textColor),
          ),
        ),
      ),
    );
  }
}

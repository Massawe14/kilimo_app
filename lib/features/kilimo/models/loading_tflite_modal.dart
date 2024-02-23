// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16.0),
          Text("Loading TensorFlow Lite Model..."),
        ],
      ),
    );
  }
}

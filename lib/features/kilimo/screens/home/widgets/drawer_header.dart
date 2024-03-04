import 'package:flutter/material.dart';

import '../../../../../util/constants/colors.dart';
import '../../../../../util/constants/image_strings.dart';

class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) => Material(
    color: TColors.primary,
    child: InkWell(
      onTap: () {
        // Close navigation drawer before
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage(TImages.profileImage),
            ),
            SizedBox(height: 12),
            Text('User Name', style: TextStyle(color: TColors.white, fontSize: 28)),
            Text('user@email.com', style: TextStyle(color: TColors.white, fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}

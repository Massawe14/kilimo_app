import 'package:flutter/material.dart';

import 'drawer_header.dart';
import 'drawer_list.dart';

class NavigationDrawerMenu extends StatelessWidget {
  const NavigationDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) => const Drawer(
    elevation: 0,
    shape: Border(right: BorderSide(color: Colors.transparent)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyHeaderDrawer(),
        MyDrawerList(),
      ],
    ),
  );
}

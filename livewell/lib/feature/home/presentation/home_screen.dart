import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      floatingActionButton: FabCircularMenu(
          ringColor: Colors.transparent,
          children: HomeTab.values
              .map((e) => e.getIcons())
              .map((e) => e.icon)
              .map((e) => IconButton(onPressed: () {}, icon: Icon(e)))
              .toList()),
    );
  }
}

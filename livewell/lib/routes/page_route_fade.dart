import 'package:flutter/material.dart';

class PageRouteFade extends MaterialPageRoute {
  int duration;

  PageRouteFade(direct, this.duration) : super(builder: (context) => direct);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Duration get transitionDuration {
    return Duration(milliseconds: duration);
  }
}

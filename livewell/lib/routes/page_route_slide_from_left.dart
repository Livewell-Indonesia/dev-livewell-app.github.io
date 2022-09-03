import 'package:flutter/cupertino.dart';

class PageRouteSlideFromLeft extends PageRouteBuilder {
  int duration;

  PageRouteSlideFromLeft(direct, this.duration)
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return direct;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        });

  @override
  Duration get transitionDuration {
    return Duration(milliseconds: duration);
  }
}

class PageRouteSlideFromLeft2 extends CupertinoPageRoute {
  int duration;

  PageRouteSlideFromLeft2(direct, this.duration)
      : super(
          builder: (context) {
            return direct;
          },
          fullscreenDialog: false,
        );

  @override
  Duration get transitionDuration {
    return Duration(milliseconds: duration);
  }
}

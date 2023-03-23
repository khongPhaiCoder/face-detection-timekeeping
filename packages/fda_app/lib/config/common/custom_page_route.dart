import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute(
      {required this.child,
      this.time,
      this.direction = AxisDirection.left,
      RouteSettings? settings})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => child,
            transitionDuration: Duration(milliseconds: time ?? 300),
            reverseTransitionDuration: Duration(milliseconds: time ?? 300),
            settings: settings);
  final Widget child;
  final int? time;

  final AxisDirection direction;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: getBeginOffset(), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
    }
  }
}

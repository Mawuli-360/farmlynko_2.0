import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget child;
  final bool slideVertically;

  SlidePageRoute({required this.child, this.slideVertically = false})
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: slideVertically ? const Offset(0, 1) : const Offset(1, 0),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
        child: child,
      );
}

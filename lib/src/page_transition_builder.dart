import 'package:flutter/material.dart';
import 'route_side.dart'; // ใช้ SlideDirection และ RouteEffect

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  final SlideDirection direction;
  final RouteEffect effect;
  final Duration duration;
  final Curve curve;

  const CustomPageTransitionBuilder({
    this.direction = SlideDirection.right,
    this.effect = RouteEffect.slide,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
  });

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final slide = SlideTransition(
      position: Tween<Offset>(
        begin: _getOffset(direction),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );

    final fade = FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: curve),
      child: child,
    );

    final scale = ScaleTransition(
      scale: CurvedAnimation(parent: animation, curve: curve),
      child: child,
    );

    switch (effect) {
      case RouteEffect.fade:
        return fade;
      case RouteEffect.scale:
        return scale;
      case RouteEffect.all:
        return slide; // หรือผสม slide + fade + scale ได้
      case RouteEffect.instant:
        return child;
      case RouteEffect.slide:
        return slide;
    }
  }

  Offset _getOffset(SlideDirection from) {
    switch (from) {
      case SlideDirection.top:
        return const Offset(0, -1);
      case SlideDirection.bottom:
        return const Offset(0, 1);
      case SlideDirection.left:
        return const Offset(1, 0);
      case SlideDirection.right:
        return const Offset(-1, 0);
      case SlideDirection.none:
        return Offset.zero;
    }
  }
}

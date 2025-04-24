import 'package:flutter/material.dart';

enum SlideDirection { top, bottom, left, right, none }

enum RouteEffect { slide, scale, fade, all, instant }

class RouteSide {
  static Route<T> transition<T>(
    Widget page, {
    SlideDirection from = SlideDirection.none,
    RouteEffect effect = RouteEffect.all,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
  }) {
    final Offset begin = _getOffset(from);

    return PageRouteBuilder<T>(
      transitionDuration: effect == RouteEffect.instant ? Duration.zero : duration,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );

        final fade = FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );

        final scale = ScaleTransition(
          scale: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );

        switch (effect) {
          case RouteEffect.slide:
            return slide;
          case RouteEffect.scale:
            return scale;
          case RouteEffect.fade:
            return fade;
          case RouteEffect.instant:
            return child;
          case RouteEffect.all:
            return SlideTransition(
              position: Tween<Offset>(begin: begin, end: Offset.zero).animate(animation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 1, end: 1).animate(animation),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                  child: child,
                ),
              ),
            );
        }
      },
    );
  }

  static Offset _getOffset(SlideDirection from) {
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

  // 🚀 Shorthands
  static Route<T> noSlide<T>(Widget page) => transition<T>(
    page,
    from: SlideDirection.none,
    effect: RouteEffect.fade,
    duration: const Duration(milliseconds: 100),
  );

  static Route<T> slideTop<T>(Widget page) => transition<T>(page, from: SlideDirection.top);
  static Route<T> slideBottom<T>(Widget page) => transition<T>(page, from: SlideDirection.bottom);
  static Route<T> slideLeft<T>(Widget page) => transition<T>(page, from: SlideDirection.left);
  static Route<T> slideRight<T>(Widget page) => transition<T>(page, from: SlideDirection.right);
  static Route<T> scaleUp<T>(Widget page) => transition<T>(page, effect: RouteEffect.scale);
  static Route<T> fadeOnly<T>(Widget page) => transition<T>(page, effect: RouteEffect.fade);
  static Route<T> instant<T>(Widget page) => transition<T>(page, effect: RouteEffect.instant);
}

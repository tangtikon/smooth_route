import 'package:flutter/material.dart';
import 'route_side.dart';

/// A custom page transition builder for use with ThemeData.pageTransitionsTheme.
///
/// Applies consistent transition effects app-wide, including slide, fade, or scale.
class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  /// Creates a custom page transition builder.
  ///
  /// [direction] defines the slide offset.
  /// [effect] controls the type of transition.
  /// [duration] defines how long the animation takes.
  /// [curve] controls the animation timing curve.
  const CustomPageTransitionBuilder({
    this.direction = SlideDirection.right,
    this.effect = RouteEffect.slide,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOut,
  });

  /// Direction to slide the new page from.
  final SlideDirection direction;

  /// Type of transition to use (slide, scale, fade, etc).
  final RouteEffect effect;

  /// Duration of the animation.
  final Duration duration;

  /// Curve of the animation.
  final Curve curve;

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
        return slide;
      case RouteEffect.instant:
        return child;
      case RouteEffect.slide:
        return slide;
    }
  }

  /// Converts [SlideDirection] to a slide [Offset].
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

import 'package:flutter/material.dart';

/// Defines the direction for the optional slide in [RouteFade].
enum SlideFrom { top, bottom, left, right, none }

/// Provides page transitions with fade effect, and optionally slide from a direction.
class RouteFade {
  /// Creates a fade transition combined with optional slide from direction [from].
  static Route<T> transition<T>(
    Widget page, {
    SlideFrom from = SlideFrom.none,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    final Offset begin = _getOffset(from);

    return PageRouteBuilder<T>(
      transitionDuration: duration,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn)),
            child: child,
          ),
        );
      },
    );
  }

  /// Converts [SlideFrom] enum to [Offset] used for sliding.
  static Offset _getOffset(SlideFrom from) {
    switch (from) {
      case SlideFrom.top:
        return const Offset(0.0, -1.0);
      case SlideFrom.bottom:
        return const Offset(0.0, 1.0);
      case SlideFrom.left:
        return const Offset(1.0, 0.0);
      case SlideFrom.right:
        return const Offset(-1.0, 0.0);
      case SlideFrom.none:
        return Offset.zero;
    }
  }

  /// Simple fade transition with no slide.
  static Route<T> fade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 150),
  }) => transition<T>(page, from: SlideFrom.none, duration: duration);

  /// Slide from top + fade transition.
  static Route<T> slideTop<T>(Widget page) =>
      transition<T>(page, from: SlideFrom.top);

  /// Slide from bottom + fade transition.
  static Route<T> slideBottom<T>(Widget page) =>
      transition<T>(page, from: SlideFrom.bottom);

  /// Slide from left + fade transition.
  static Route<T> slideLeft<T>(Widget page) =>
      transition<T>(page, from: SlideFrom.left);

  /// Slide from right + fade transition.
  static Route<T> slideRight<T>(Widget page) =>
      transition<T>(page, from: SlideFrom.right);
}

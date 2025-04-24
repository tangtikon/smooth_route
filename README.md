# 🚀 smooth_route

[![pub package](https://img.shields.io/pub/v/smooth_route.svg)](https://pub.dev/packages/smooth_route)
[![platform](https://img.shields.io/badge/platform-Flutter-blue)](https://flutter.dev)

Custom route transitions for Flutter apps.  
Smooth, composable, and flexible page navigation with slide, fade, scale, and instant transitions.

## ✨ Features

- Slide from top, bottom, left, right
- Fade in/out
- Scale transition
- Instant (no animation)
- Combine slide + fade + scale
- Enum-based API for readability
- Global `ThemeData.pageTransitionsTheme` support
- Curve and duration customization

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  smooth_route: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Usage

Import the package:

```dart
import 'package:smooth_route/smooth_route.dart';
```

Then use it in `Navigator.push(...)`:

```dart
Navigator.of(context).push(RouteSide.slideLeft(MyPage()));
Navigator.of(context).push(RouteFade.fade(MyPage()));
Navigator.of(context).push(RouteSide.scaleUp(MyPage()));
Navigator.of(context).push(RouteSide.instant(MyPage()));
```

## 🔀 Transition Types

| Transition     | Method                          |
|----------------|---------------------------------|
| Slide Left     | `RouteSide.slideLeft(...)`      |
| Slide Right    | `RouteSide.slideRight(...)`     |
| Slide Top      | `RouteSide.slideTop(...)`       |
| Slide Bottom   | `RouteSide.slideBottom(...)`    |
| Scale Up       | `RouteSide.scaleUp(...)`        |
| Fade Only      | `RouteFade.fade(...)`           |
| Fade + Slide   | `RouteFade.slideRight(...)`     |
| No Animation   | `RouteSide.instant(...)`        |
| Custom Slide   | `RouteSide.transition(...)`     |

All methods support generic return types `<T>` and can be customized.

## 🎨 Global Transitions (Optional)

You can apply global page transition effects across your entire app using `ThemeData.pageTransitionsTheme`:

```dart
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionBuilder(
          direction: SlideDirection.right,
          effect: RouteEffect.slide,
          duration: Duration(milliseconds: 300),
        ),
        TargetPlatform.iOS: CustomPageTransitionBuilder(
          direction: SlideDirection.left,
          effect: RouteEffect.fade,
          duration: Duration(milliseconds: 300),
        ),
      },
    ),
  ),
)
```

✅ Note: Using `pageTransitionsTheme` is optional.  
You can also apply transitions individually using `RouteSide` or `RouteFade`.
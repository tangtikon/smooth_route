import 'package:flutter/material.dart';
import 'package:smooth_route/smooth_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Route Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        //Enable global page transitions
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: const CustomPageTransitionBuilder(
              direction: SlideDirection.right,
              effect: RouteEffect.slide,
            ),
            TargetPlatform.iOS: const CustomPageTransitionBuilder(
              direction: SlideDirection.left,
              effect: RouteEffect.fade,
            ),
          },
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedRoute Example')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  RouteSide.slideLeft(const NextPage(title: 'Slide Left')),
                ),
            child: const Text('Slide from Left'),
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  RouteSide.slideBottom(const NextPage(title: 'Slide Bottom')),
                ),
            child: const Text('Slide from Bottom'),
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(context, RouteSide.scaleUp(const NextPage(title: 'Scale Up'))),
            child: const Text('Scale Up'),
          ),
          ElevatedButton(
            onPressed:
                () =>
                    Navigator.push(context, RouteSide.fadeOnly(const NextPage(title: 'Fade Only'))),
            child: const Text('Fade Only'),
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  RouteSide.instant(const NextPage(title: 'No Animation')),
                ),
            child: const Text('Instant (no transition)'),
          ),
          const Divider(height: 32),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  RouteFade.slideRight(const NextPage(title: 'Fade + Slide Right')),
                ),
            child: const Text('RouteFade: Slide Right + Fade'),
          ),
          ElevatedButton(
            onPressed:
                () => Navigator.push(
                  context,
                  RouteFade.fade(const NextPage(title: 'RouteFade Only')),
                ),
            child: const Text('RouteFade: Fade only'),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String title;
  const NextPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(child: Text('You have arrived', style: TextStyle(fontSize: 24))),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:rentora/features/splash/widgets/splash_screen_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Logo Animations
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;

  // Letters Animations
  final List<Animation<Offset>> _lettersSlide = [];
  final List<Animation<double>> _lettersOpacity = [];

  final List<String> _lettersSvg = [
    "R.svg",
    "E.svg",
    "N.svg",
    "T.svg",
    "O.svg",
    "R_Green.svg",
    "A.svg",
  ];

  @override
  void initState() {
    super.initState();

    // Total animation time is 2.5 seconds for a snappy feel
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    //  Logo Animation (0% to 40% of the time)
    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Letters Animation (Staggered from 30% to 80% of the time)
    for (int i = 0; i < _lettersSvg.length; i++) {
      double start = 0.3 + (i * 0.05);
      double end = start + 0.2;
      if (end > 1.0) end = 1.0;

      _lettersSlide.add(
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          ),
        ),
      );

      _lettersOpacity.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeIn),
          ),
        ),
      );
    }

    // Start animation and navigate after it finishes
    _controller.forward().then((value) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          // context.pushReplacementNamed(Routes.onBoardingRoute);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SplashScreenContent(
            logoScale: _logoScale,
            logoOpacity: _logoOpacity,
            lettersSlide: _lettersSlide,
            lettersOpacity: _lettersOpacity,
            lettersSvg: _lettersSvg,
          );
        },
      ),
    );
  }
}
// 160
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/shared_prefrences_helper.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';

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

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

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

    _controller.forward().then((value) async {
      await Future.delayed(const Duration(milliseconds: 400));

      if (!mounted) return;

      bool hasSeenOnboarding = await SharedPrefHelper.getBool(
        'hasSeenOnboarding',
      );
      if (!hasSeenOnboarding) {
        if (mounted) {
          context.pushReplacementNamed(Routes.onBoardingScreens);
        }
        return;
      }

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        if (mounted) {
          context.pushReplacementNamed(Routes.welcomeAuthScreen);
        }

        return;
      }

      if (!currentUser.emailVerified) {
        await FirebaseAuth.instance.signOut();
        if (mounted) {
          context.pushReplacementNamed(Routes.welcomeAuthScreen);
        }
        return;
      }

      bool hasFinishedSetup = await SharedPrefHelper.getBool(
        'hasFinishedSetup',
      );
      if (!hasFinishedSetup) {
        if (mounted) {
          context.pushReplacementNamed(Routes.locationScreen);
        }
        return;
      }

      if (mounted) {
        context.pushReplacementNamed(Routes.rootScreen);
      }
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
      backgroundColor: AppColors.white,
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

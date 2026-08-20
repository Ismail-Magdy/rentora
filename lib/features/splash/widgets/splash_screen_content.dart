import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentora/core/helpers/spacing.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({
    super.key,
    required this.logoScale,
    required this.logoOpacity,
    required this.lettersSlide,
    required this.lettersOpacity,
    required this.lettersSvg,
  });

  // Logo Animations
  final Animation<double> logoScale;
  final Animation<double> logoOpacity;

  // Letters Animations
  final List<Animation<Offset>> lettersSlide;
  final List<Animation<double>> lettersOpacity;

  final List<String> lettersSvg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          // Main Logo
          Transform.scale(
            scale: logoScale.value,
            child: Opacity(
              opacity: logoOpacity.value,
              child: SvgPicture.asset(
                "assets/svgs/logo/logo.svg",
                width: 120.w,
              ),
            ),
          ),
          //
          verticalSpace(24),
          // RENTORA Text
          Row(
            mainAxisAlignment: .center,
            children: List.generate(lettersSvg.length, (index) {
              return SlideTransition(
                position: lettersSlide[index],
                child: Opacity(
                  opacity: lettersOpacity[index].value,
                  child: Padding(
                    padding: .symmetric(horizontal: 2.w),
                    child: SvgPicture.asset(
                      "assets/svgs/logo/${lettersSvg[index]}",
                      height: 20.h,
                    ),
                  ),
                ),
              );
            }),
          ),
          //
        ],
      ),
    );
  }
}

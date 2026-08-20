import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/on_boarding/data/on_boarding_screens_data.dart';
import 'package:rentora/features/on_boarding/presentation/widgets/on_boarding_pages.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  int _currentPage = 0;
  //
  final PageController _pageController = PageController();

  //
  void _nextPage() {
    if (_currentPage < onbourdingScreenData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboaring();
    }
  }

  void _finishOnboaring() =>
      context.pushReplacementNamed(Routes.welcomeAuthScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            //
            Padding(
              padding: .fromLTRB(25.w, 10.h, 25.w, 80.h),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  //
                  Image.asset(
                    "assets/images/on_boarding/logo.png",
                    fit: .contain,
                    width: 130.w,
                  ),
                  //
                  GestureDetector(
                    onTap: _finishOnboaring,
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontWeight: .bold,
                        fontSize: 14.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
            //
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onbourdingScreenData.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) =>
                    buildOnBoardingScreen(onbourdingScreenData[index]),
              ),
            ),
            //
            verticalSpace(80),
            //
            Row(
              mainAxisAlignment: .center,
              children: List.generate(onbourdingScreenData.length, (index) {
                final bool isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: .symmetric(horizontal: 4.w),
                  width: isActive ? 28.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryColor
                        : AppColors.darkGrey,
                    borderRadius: .circular(10.r),
                  ),
                );
              }),
            ),
            //
            verticalSpace(46),
            //
            Padding(
              padding: .fromLTRB(25.w, 0, 25.w, 20.h),
              child: CustomButton(
                height: 52.h,
                text: _currentPage == 3 ? "Get Started" : "Next",
                onPressed: _nextPage,
                fontSize: 16,
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}

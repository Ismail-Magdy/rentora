import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/helpers/verification_guard.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/home/presentation/screens/home_screen.dart';
import 'package:rentora/features/chat/presentation/screens/chat_list_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ChatListScreen(),
    Center(child: Text('Archive Screen')),
    Center(child: Text('Settings Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildCustomBottomNavigationBar(),
    );
  }

  Widget _buildCustomBottomNavigationBar() {
    return SizedBox(
      height: 105.h,
      child: Stack(
        alignment: .bottomCenter,
        children: [
          //
          Container(
            height: 85.h,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: .vertical(top: .circular(24.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: 19.r,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Padding(
              padding: .only(left: 12.w, right: 12.w, bottom: 16.h),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  // Left Tabs
                  _buildNavItem(index: 0, iconName: "home", label: "Home"),
                  _buildNavItem(index: 1, iconName: "chat", label: "Chat"),
                  //
                  SizedBox(
                    width: 50.w,
                    child: Column(
                      mainAxisAlignment: .end,
                      children: [
                        //
                        Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: .w500,
                            color: AppColors.darkGrey,
                          ),
                        ),
                        //
                        verticalSpace(12),
                        //
                      ],
                    ),
                  ),
                  //
                  // Right Tabs
                  _buildNavItem(
                    index: 2,
                    iconName: "archive",
                    label: "Archive",
                  ),
                  _buildNavItem(
                    index: 3,
                    iconName: 'settings',
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),
          //
          ///
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () => VerificationGuard.check(
                context,
                onVerified: () => context.pushNamed(Routes.initialPhotoScreen),
              ),
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: .circle,
                ),
                child: Icon(Icons.add, color: AppColors.white, size: 26.sp),
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  ///
  Widget _buildNavItem({
    required int index,
    required String iconName,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() {
        _currentIndex = index;
      }),

      behavior: .opaque,
      child: SizedBox(
        width: 65.w,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            //
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: .all(8.r),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.3)
                    : Colors.transparent,
                shape: .circle,
              ),
              child: SvgPicture.asset(
                "assets/svgs/root/$iconName.svg",
                width: 22.w,
                height: 22.h,
                colorFilter: ColorFilter.mode(
                  isSelected ? AppColors.primaryColor : AppColors.grey,
                  .srcIn,
                ),
              ),
            ),
            //
            verticalSpace(4),
            //
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? .bold : .w500,
                color: isSelected ? AppColors.primaryColor : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
}
// 189
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/presentation/models/verification_route_args.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_badge_header.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_benefit_card.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_footer_security.dart';
import 'package:rentora/features/verification/presentation/widgets/verification_requirement_item.dart';

class VerificationIntroScreen extends StatelessWidget {
  const VerificationIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(text: "Account verification"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace(10),
                    const VerificationBadgeHeader(),
                    verticalSpace(20),
                    Text(
                      "Build Trust in the Community",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    verticalSpace(8),
                    Text(
                      "Verifying your account with a few simple steps gives you a Verified Badge, speeds up request approvals, and gives you access to a higher rental limit.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.darkGrey,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    verticalSpace(20),
                    const VerificationBenefitCard(
                      icon: Icons.bolt_outlined,
                      title: "Faster Approvals",
                      description:
                          "Owners prefer dealing with verified accounts.",
                    ),
                    verticalSpace(12),
                    const VerificationBenefitCard(
                      icon: Icons.trending_up_outlined,
                      title: "Higher Rental Limit",
                      description:
                          "Rent higher-value equipment without restrictions.",
                    ),
                    verticalSpace(20),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verification Requirements:",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          verticalSpace(14),
                          const VerificationRequirementItem(
                            icon: Icons.badge_outlined,
                            title: "Valid National ID or Residency Permit",
                            description: "A clear photo of both sides.",
                          ),
                          verticalSpace(12),
                          const VerificationRequirementItem(
                            icon: Icons.face_retouching_natural_rounded,
                            title: "Quick Face Scan (Selfie)",
                            description: "To verify that it matches your ID.",
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                bottom: 28.h,
                top: 12.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    text: "Start Verification Now",
                    suffixIcon: Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.white,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      context.pushNamed(
                        Routes.verificationFaceScanScreen,
                        arguments: VerificationRouteArgs(
                          verificationCubit: context.read<VerificationCubit>(),
                        ),
                      );
                    },
                    borderRadius: 16.r,
                    height: 52.h,
                    color: AppColors.primaryColor,
                  ),
                  verticalSpace(12),
                  const VerificationFooterSecurity(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

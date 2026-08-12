import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';

class CustomFeedbackDialog extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final VoidCallback? onFinish;

  const CustomFeedbackDialog({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: .symmetric(horizontal: 24.w),
        padding: .only(top: 24.h, left: 24.w, right: 24.w, bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        clipBehavior: .antiAlias,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: .min,
            children: [
              //
              Container(
                padding: .all(16.w),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: .circle,
                ),
                child: Icon(icon, color: color, size: 50.sp),
              ),
              //
              verticalSpace(20),
              // Title
              Text(
                title,
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: .bold,
                  color: color,
                ),
              ),
              //
              verticalSpace(12),
              //
              // Message
              Text(
                message,
                textAlign: .center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              //
              verticalSpace(24),
              //
              // Linear Progress
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 2500),
                onEnd: () {
                  // When the progress bar finishes, we first check if the dialog can be popped (closed) and then execute the onFinish callback if provided
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  }
                  onFinish?.call();
                },
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 5.h,
                  );
                },
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}

/// Function to show the custom feedback dialog with a progress bar and optional callback when finished
void showFeedbackDialog(
  BuildContext context, {
  required IconData icon,
  required Color color,
  required String title,
  required String message,
  VoidCallback? onFinish,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Feedback",
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) {
      return CustomFeedbackDialog(
        icon: icon,
        color: color,
        title: title,
        message: message,
        onFinish: onFinish,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return Transform.scale(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        ).value,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

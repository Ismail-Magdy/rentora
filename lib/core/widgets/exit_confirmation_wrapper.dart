import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:rentora/core/themes/app_colors.dart";
import "package:rentora/l10n/generated/app_localizations.dart";

class ExitConfirmationWrapper extends StatelessWidget {
  final Widget child;

  const ExitConfirmationWrapper({super.key, required this.child});

  Future<bool> _onWillPop(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: .circular(16.r)),
        //
        title: Text(
          l10n.exitApp,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: .bold,
            color: isDark ? AppColors.darkTextPrimary : Colors.black87,
          ),
        ),
        //
        content: Text(
          l10n.exitConfirmation,
          style: TextStyle(
            fontSize: 14.sp,
            color: isDark ? AppColors.darkTextSecondary : Colors.grey.shade700,
          ),
        ),
        //
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              l10n.cancel,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? AppColors.darkTextMuted : Colors.grey.shade600,
                fontWeight: .w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.exit,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? AppColors.secondaryColor : AppColors.primaryColor,
                fontWeight: .bold,
              ),
            ),
          ),
        ],
        //
      ),
    );

    if (shouldExit == true) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop(context);
        }
      },
      child: child,
    );
  }
}

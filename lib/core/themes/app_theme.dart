import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: AppColors.white,
        primaryContainer: Color(0xFFD4EFF2),
        onPrimaryContainer: Color(0xFF003840),
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.white,
        secondaryContainer: Color(0xFFC7ECF0),
        onSecondaryContainer: Color(0xFF00343C),
        surface: AppColors.white,
        onSurface: AppColors.black,
        surfaceContainerHighest: Color(0xFFF2F3F5),
        error: AppColors.error,
        onError: AppColors.white,
        outline: AppColors.lightGrey,
        outlineVariant: AppColors.dividerColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryColor, size: 22.sp),
        actionsIconTheme: IconThemeData(
          color: AppColors.primaryColor,
          size: 22.sp,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadowColor: AppColors.lightGrey.withValues(alpha: 0.5),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.darkGrey,
        selectedIconTheme: IconThemeData(size: 24.sp),
        unselectedIconTheme: IconThemeData(size: 22.sp),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey.withValues(alpha: 0.08),
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.grey,
          fontSize: 14.sp,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.darkGrey,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.error, width: 2.w),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor, width: 1.w),
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        contentTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.darkGrey,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.dividerColor,
        thickness: 1.h,
        space: 1.h,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.lightGrey;
        }),
      ),
      iconTheme: IconThemeData(color: AppColors.primaryColor, size: 24.sp),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 57.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 45.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 36.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 32.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.sp,
          color: AppColors.black,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.normal,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11.sp,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.secondaryColor,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primaryColor,
        onPrimaryContainer: AppColors.white,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.white,
        secondaryContainer: Color(0xFF004D56),
        onSecondaryContainer: AppColors.white,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainerHighest: AppColors.darkContainer,
        error: AppColors.error,
        onError: AppColors.white,
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.darkDivider,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary, size: 22.sp),
        actionsIconTheme: IconThemeData(
          color: AppColors.darkTextPrimary,
          size: 22.sp,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        shadowColor: AppColors.darkShadow,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.darkTextSecondary,
        selectedIconTheme: IconThemeData(size: 24.sp),
        unselectedIconTheme: IconThemeData(size: 22.sp),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkContainer,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.darkTextMuted,
          fontSize: 14.sp,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AppColors.darkTextSecondary,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.secondaryColor, width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: AppColors.error, width: 2.w),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.secondaryColor,
          side: BorderSide(color: AppColors.secondaryColor, width: 1.w),
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondaryColor,
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        contentTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.darkTextSecondary,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1.h,
        space: 1.h,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.white;
          }
          return AppColors.darkTextMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.secondaryColor;
          }
          return AppColors.darkBorder;
        }),
      ),
      iconTheme: IconThemeData(color: AppColors.darkIcon, size: 24.sp),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 57.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 45.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 36.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 32.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.darkTextSecondary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          color: AppColors.darkTextSecondary,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12.sp,
          color: AppColors.darkTextSecondary,
          fontWeight: FontWeight.normal,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11.sp,
          color: AppColors.darkTextMuted,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

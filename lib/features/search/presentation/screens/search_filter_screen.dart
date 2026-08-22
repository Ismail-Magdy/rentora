import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/search/manager/search_cubit.dart';
import 'package:rentora/features/search/presentation/widgets/search_filters.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19.sp,
            color: AppColors.black,
          ),
        ),
        title: Text(
          'Filters',
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<SearchCubit>().clearFilters();
            },
            child: Text(
              'Clear',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: const SafeArea(child: SearchFilters()),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
          child: SizedBox(
            height: 52.h,
            child: ElevatedButton(
              onPressed: () async {
                await context.read<SearchCubit>().applyFilters();

                if (!context.mounted) return;

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: Text(
                'Apply Filters',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

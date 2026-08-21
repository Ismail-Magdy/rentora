import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/presentation/widgets/home_products_grid.dart';

class SearchResults extends StatelessWidget {
  final List<ProductModel> products;
  final bool isLoading;
  final String? errorMessage;

  const SearchResults({
    super.key,
    required this.products,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 60.sp,
                  color: AppColors.darkGrey,
                ),

                SizedBox(height: 16.h),

                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!isLoading && products.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 64.sp,
                  color: AppColors.darkGrey,
                ),

                SizedBox(height: 16.h),

                Text(
                  'No products found',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Try changing your search or filters.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return HomeProductsGrid(
      products: products,
      isLoading: isLoading,
    );
  }
}
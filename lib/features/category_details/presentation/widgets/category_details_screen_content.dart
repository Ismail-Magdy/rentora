import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/presentation/widgets/product_card.dart';

class CategoryDetailsScreenContent extends StatelessWidget {
  const CategoryDetailsScreenContent({
    super.key,
    required this.categoryName,
    required this.isLoading,
    required this.displayList,
  });
  final String categoryName;
  final bool isLoading;
  final List<ProductModel> displayList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          //
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black,
              ),
            ),
            title: Text(
              categoryName.capitalizeFirst(),
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: .bold,
                fontSize: 18.sp,
              ),
            ),
            centerTitle: true,
          ),
          //

          // Empty State
          if (!isLoading && displayList.isEmpty)
            SliverToBoxAdapter(
              child: Container(
                height: 600.h,
                alignment: .center,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    //
                    Lottie.asset(
                      "assets/lottie/no_products.json",
                      height: 450.h,
                    ),
                    //
                    Text(
                      "No Products Found",
                      style: TextStyle(
                        fontWeight: .bold,
                        fontSize: 18.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    //
                    verticalSpace(8),
                    //
                    Text(
                      "Be the first to add an item here",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.darkGrey,
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),

          if (displayList.isNotEmpty)
            SliverPadding(
              padding: .symmetric(horizontal: 16.w, vertical: 16.h),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!isLoading) {
                        context.pushNamed(
                          Routes.itemDetailsScreen,
                          arguments: displayList[index].id,
                        );
                      }
                    },
                    child: ProductCard(product: displayList[index]),
                  );
                }, childCount: displayList.length),
              ),
            ),
        ],
      ),
    );
  }
}

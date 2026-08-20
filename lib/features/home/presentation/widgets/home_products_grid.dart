import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/presentation/widgets/product_card.dart';

class HomeProductsGrid extends StatelessWidget {
  final List<ProductModel> products;
  final bool isLoading;

  const HomeProductsGrid({
    super.key,
    required this.products,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading && products.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 500.h,
          alignment: .topCenter,
          child: Column(
            mainAxisSize: .min,
            children: [
              //
              Lottie.asset("assets/lottie/no_products.json", height: 400.h),
              //
              Text(
                "No products available right now",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: .w500,
                  color: AppColors.grey,
                ),
                //
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: .symmetric(horizontal: 16.w),
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
                  arguments: products[index].id,
                );
              }
            },
            child: ProductCard(product: products[index]),
          );
        }, childCount: products.length),
      ),
    );
  }
}

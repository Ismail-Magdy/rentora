import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/presentation/widgets/product_card.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizedCategoryTitle = CategoryModel(
      id: categoryName,
      name: categoryName,
      iconPath: '',
    ).getLocalizedName(l10n);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          //
          SliverAppBar(
            pinned: true,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: isDark ? AppColors.darkTextPrimary : AppColors.black,
              ),
            ),
            title: Text(
              localizedCategoryTitle,
              style: TextStyle(
                color: isDark ? AppColors.darkTextPrimary : AppColors.primaryColor,
                fontWeight: FontWeight.bold,
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
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    Lottie.asset(
                      "assets/lottie/no_products.json",
                      height: 450.h,
                    ),
                    //
                    Text(
                      l10n.noProductsFound,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    //
                    verticalSpace(8),
                    //
                    Text(
                      l10n.firstItemPrompt,
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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

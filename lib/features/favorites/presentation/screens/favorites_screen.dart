import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/presentation/widgets/product_card.dart';
import 'package:rentora/features/setup_profile/data/models/category_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    // Refresh favorites when entering screen
    context.read<FavoritesCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(text: "Favourites"),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final isLoading = state is FavoritesLoading || state is FavoritesInitial;
          final favorites = isLoading
              ? List.generate(
                  4,
                  (index) => ProductModel(
                    id: index.toString(),
                    name: 'Skeleton Product Name',
                    category: 'Category',
                    price: 1500,
                    rating: 4.5,
                    distance: 2.0,
                    imageUrl: '',
                  ),
                )
              : context.read<FavoritesCubit>().favorites;

          final List<String> categories = ['All'];
          categories.addAll(CategoryModel.categories.map((e) => e.name));

          // Filter items based on selected category
          final filteredItems = _selectedCategory == 'All'
              ? favorites
              : favorites
                  .where((item) => item.category == _selectedCategory)
                  .toList();

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              children: [
                // Category Filter
                SizedBox(
                  height: 40.h,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: categories.map((category) {
                        final isSelected = category == _selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            if (!isLoading) {
                              setState(() => _selectedCategory = category);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : Colors.grey.shade300,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                verticalSpace(16),

                // Favorites Grid
                Expanded(
                  child: filteredItems.isEmpty
                      ? Lottie.asset("assets/lottie/no_products.json")
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: filteredItems[index]);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

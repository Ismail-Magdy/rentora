import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/error_screen.dart';
import 'package:rentora/features/home/manager/home_cubit.dart';
import 'package:rentora/features/home/presentation/widgets/home_products_grid.dart';
import 'package:rentora/features/home/presentation/widgets/home_top_bar.dart';
import 'package:rentora/features/home/presentation/widgets/home_categories.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeData();
  }

  // Dummy data for products to show while loading
  final List<ProductModel> _dummyProducts = List.generate(
    6,
    (index) => ProductModel(
      id: index.toString(),
      name: "Product Name Skeleton",
      price: 1500,
      rating: 4.5,
      distance: 3.5,
      imageUrl: "",
    ),
  );

  // Dummy data for categories to show while loading
  final List<String> _dummyCategories = [
    "Cameras",
    "Gaming",
    "Sports",
    "Tools",
    "Books",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // Map Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Map Screen
        },
        backgroundColor: Colors.teal,
        icon: SvgPicture.asset(
          "assets/svgs/home/map.svg",
          width: 20.w,
          height: 20.h,
          colorFilter: ColorFilter.mode(AppColors.white, .srcIn),
        ),
        label: Text(
          "View Map",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: .bold,
            color: AppColors.white,
          ),
        ),
      ),
      //
      floatingActionButtonLocation: .endFloat,
      //
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeError) {
              return ErrorScreen();
            }

            final bool isLoading = state is HomeInitial || state is HomeLoading;

            final List<String> displayCategories = isLoading
                ? _dummyCategories
                : (state as HomeLoaded).categories;

            final List<ProductModel> displayProducts = isLoading
                ? _dummyProducts
                : (state as HomeLoaded).products;

            return Skeletonizer(
              enabled: isLoading,
              child: CustomScrollView(
                slivers: [
                  //
                  const SliverToBoxAdapter(child: HomeTopBar()),
                  //
                  SliverToBoxAdapter(
                    child: HomeCategories(categories: displayCategories),
                  ),
                  //
                  HomeProductsGrid(
                    products: displayProducts,
                    isLoading: isLoading,
                  ),
                  //
                  SliverToBoxAdapter(child: verticalSpace(100)),
                  //
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

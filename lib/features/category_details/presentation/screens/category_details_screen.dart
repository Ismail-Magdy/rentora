import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/widgets/error_screen.dart';
import 'package:rentora/features/category_details/manager/category_details_cubit.dart';
import 'package:rentora/features/category_details/manager/category_details_state.dart';
import 'package:rentora/features/category_details/presentation/widgets/category_details_screen_content.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryDetailsScreen({super.key, required this.categoryName});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryDetailsCubit>().getProductsByCategory(
      widget.categoryName,
    );
  }

  final List<ProductModel> _dummyProducts = List.generate(
    6,
    (index) => ProductModel(
      id: 'skeleton_$index',
      name: 'Loading Item Name',
      category: 'Skeleton',
      price: 999,
      rating: 5.0,
      distance: 9.9,
      imageUrl:
          'https://dummyimage.com/400x300/cccccc/000000.png&text=Loading...',
      isFavorite: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
      builder: (context, state) {
        // Error
        if (state is CategoryDetailsError) {
          return ErrorScreen();
        }

        final bool isLoading =
            state is CategoryDetailsLoading || state is CategoryDetailsInitial;
        final List<ProductModel> displayList = isLoading
            ? _dummyProducts
            : (state as CategoryDetailsLoaded).products;

        return Skeletonizer(
          enabled: isLoading,
          child: CategoryDetailsScreenContent(
            categoryName: widget.categoryName,
            displayList: displayList,
            isLoading: isLoading,
          ),
        );
      },
    );
  }
}

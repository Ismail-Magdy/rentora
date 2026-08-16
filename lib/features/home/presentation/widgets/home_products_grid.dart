// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rentora/features/home/data/models/product_model.dart';
// import 'package:rentora/features/home/presentation/widgets/product_card.dart';

// class HomeProductsGrid extends StatelessWidget {
//   final List<ProductModel> products;
//   final bool isLoading;

//   const HomeProductsGrid({
//     super.key,
//     required this.products,
//     this.isLoading = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (!isLoading && products.isEmpty) {
//       return SliverToBoxAdapter(
//         child: Lottie.asset("assets/lottie/no_products.json"),
//       );
//     }

//     return SliverPadding(
//       padding: .symmetric(horizontal: 16.w),
//       sliver: SliverGrid(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.w,
//           mainAxisSpacing: 16.h,
//           childAspectRatio: 0.75,
//         ),
//         delegate: SliverChildBuilderDelegate((context, index) {
//           return ProductCard(product: products[index]);
//         }, childCount: products.length),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
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
    final List<ProductModel> dummyProducts = List.generate(
      6,
      (index) => ProductModel(
        id: 'dummy_$index',
        name: 'Sony A7 III Camera',
        price: 600,
        rating: 4.8,
        distance: 3.5,
        imageUrl:
            'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=500&auto=format&fit=crop',
        isFavorite: false,
      ),
    );

    final displayList = dummyProducts;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              context.pushNamed(
                Routes.itemDetailsScreen,
                arguments: displayList[index].id,
              );
            },
            child: ProductCard(product: displayList[index]),
          );
        }, childCount: displayList.length),
      ),
    );
  }
}

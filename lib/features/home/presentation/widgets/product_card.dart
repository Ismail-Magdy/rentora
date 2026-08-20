import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Image
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.5),
                    borderRadius: .vertical(top: .circular(16.r)),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.imageUrl.isNotEmpty
                            ? product.imageUrl
                            : 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=500&auto=format&fit=crop',
                      ),
                      fit: .cover,
                    ),
                  ),
                ),
                //
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Toggle Favorite logic later
                    },
                    child: Container(
                      padding: .all(6.r),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.8),
                        shape: .circle,
                      ),
                      child: SvgPicture.asset(
                        product.isFavorite
                            ? 'assets/svgs/home/heart_fill.svg'
                            : 'assets/svgs/home/heart.svg',
                        width: 18.w,
                        height: 18.h,
                        colorFilter: .mode(
                          product.isFavorite
                              ? AppColors.error
                              : AppColors.black,
                          .srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: .all(12.r),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                //
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    //
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 14.sp, fontWeight: .bold),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    ),
                    //
                    Row(
                      children: [
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: TextStyle(fontSize: 12.sp, fontWeight: .bold),
                        ),
                        horizontalSpace(4),
                        //
                        Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      ],
                    ),
                    //
                  ],
                ),
                verticalSpace(8),
                //
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    //
                    Row(
                      crossAxisAlignment: .baseline,
                      textBaseline: .alphabetic,
                      children: [
                        //
                        Text(
                          product.price.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: .bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        //
                        horizontalSpace(4),
                        //
                        Text(
                          'EGP/day',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.grey,
                          ),
                        ),
                        //
                      ],
                    ),
                    //
                    Row(
                      children: [
                        Text(
                          '${product.distance} km',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.grey,
                          ),
                        ),
                        horizontalSpace(2),
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.grey,
                          size: 12.sp,
                        ),
                      ],
                    ),
                    //
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

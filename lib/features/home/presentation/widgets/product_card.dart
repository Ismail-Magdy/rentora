import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// الجزء اللي فوق: الصورة والقلب
          Expanded(
            child: Stack(
              children: [
                // الصورة
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    image: DecorationImage(
                      // لو مفيش صورة، حط صورة تجريبية (Placeholder)
                      image: NetworkImage(
                        product.imageUrl.isNotEmpty
                            ? product.imageUrl
                            : 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=500&auto=format&fit=crop',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // أيقونة القلب
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Toggle Favorite logic later
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        product.isFavorite
                            ? 'assets/svgs/home/heart_fill.svg'
                            : 'assets/svgs/home/heart.svg',
                        width: 18.w,
                        height: 18.h,
                        colorFilter: ColorFilter.mode(
                          product.isFavorite ? Colors.red : Colors.black87,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// الجزء اللي تحت: النصوص (الاسم، التقييم، السعر، المسافة)
          Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الاسم والتقييم
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.star, color: Colors.orange, size: 14.sp),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // السعر والمسافة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          product.price.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal, // AppColors.primaryColor
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'EGP/day',
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${product.distance} km',
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                        SizedBox(width: 2.w),
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 12.sp,
                        ),
                      ],
                    ),
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

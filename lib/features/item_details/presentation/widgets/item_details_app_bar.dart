import 'package:flutter/material.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

class ItemDetailsAppBar extends StatefulWidget {
  final ItemDetailsModel item;

  const ItemDetailsAppBar({super.key, required this.item});

  @override
  State<ItemDetailsAppBar> createState() => _ItemDetailsAppBarState();
}

class _ItemDetailsAppBarState extends State<ItemDetailsAppBar> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => context.pop(),
        child: const Icon(Icons.arrow_back_ios, color: Colors.black87),
      ),
      title: Text(
        widget.item.name.isNotEmpty ? widget.item.name : 'Rentora',
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontWeight: .bold,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0,
      actions: [
        Padding(
          padding: .only(right: 20.w, left: 15.w),
          child: GestureDetector(
            onTap: () {},
            child: const Icon(Icons.share_outlined, color: Colors.black87),
          ),
        ),
      ],
      //
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: .bottomCenter,
          children: [
            PageView.builder(
              itemCount: widget.item.imageUrls.length,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(widget.item.imageUrls[index], fit: .cover);
              },
            ),
            Positioned(
              bottom: 16.h,
              child: Row(
                mainAxisAlignment: .center,
                children: List.generate(
                  widget.item.imageUrls.length,
                  (index) => Container(
                    margin: .symmetric(horizontal: 4.w),
                    width: _currentImageIndex == index ? 8.w : 6.w,
                    height: _currentImageIndex == index ? 8.w : 6.w,
                    decoration: BoxDecoration(
                      color: _currentImageIndex == index
                          ? AppColors.primaryColor
                          : AppColors.grey.withValues(alpha: 0.7),
                      shape: .circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/helpers/verification_guard.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';

class ItemBottomNavBar extends StatelessWidget {
  final ItemDetailsModel item;

  const ItemBottomNavBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            //
            Expanded(
              child: CustomButton(
                text: "Book Now",
                onPressed: () => VerificationGuard.check(
                  context,
                  onVerified: () => context.pushNamed(
                    Routes.selectedDatesScreen,
                    arguments: BookingScreenArgs(
                      listingId: item.id,
                      ownerId: item.ownerId,
                      renterId: '',
                      dailyPrice: item.price,
                      securityDeposit: 0,
                      listingTitle: item.name,
                      listingImageUrl: item.imageUrls.isNotEmpty
                          ? item.imageUrls.first
                          : '',
                    ),
                  ),
                ),
              ),
            ),
            //
            horizontalSpace(12),
            //
            Container(
              decoration: BoxDecoration(
                border: .all(color: Colors.grey.shade300),
                borderRadius: .circular(12.r),
              ),
              child: BlocListener<FavoritesCubit, FavoritesState>(
                listener: (context, state) {
                  if (state is FavoritesActionSuccess && state.productId == item.id) {
                    showFeedbackDialog(
                      context,
                      icon: state.isAdded ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primaryColor,
                      title: state.isAdded ? 'Added to Favorites' : 'Removed from Favorites',
                      message: state.message,
                    );
                  }
                },
                child: BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    final isFav = context.read<FavoritesCubit>().isFavorite(
                      item.id,
                    );
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav
                            ? AppColors.error
                            : AppColors.grey.withValues(alpha: 0.9),
                      ),
                      onPressed: () {
                        context.read<FavoritesCubit>().toggleFavorite(
                          ProductModel(
                            id: item.id,
                            name: item.name,
                            category: '',
                            price: item.price,
                            rating: item.rating,
                            distance: item.distance,
                            imageUrl: item.imageUrls.isNotEmpty
                                ? item.imageUrls.first
                                : '',
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}

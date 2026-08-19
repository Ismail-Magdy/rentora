import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'package:rentora/features/item_details/manager/item_details_cubit.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_availability_section.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_bottom_nav_bar.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_description_section.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_details_app_bar.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_features_section.dart';
import 'package:rentora/features/item_details/presentation/widgets/item_info_section.dart';
import 'package:rentora/features/item_details/presentation/widgets/owner_info_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String itemId;

  const ItemDetailsScreen({super.key, required this.itemId});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ItemDetailsCubit>().getItemDetails(widget.itemId);
  }

  // Dummy item to show skeleton lines while loading
  final ItemDetailsModel _dummyItem = ItemDetailsModel(
    id: 'skeleton',
    name: 'Loading Item Name Skeleton...',
    price: 999,
    rating: 5.0,
    reviewsCount: 100,
    distance: 9.9,
    locationName: 'Loading Location...',
    imageUrls: [
      'https://dummyimage.com/400x300/cccccc/000000.png&text=Loading...',
    ],
    description:
        'This is a dummy description just to show the skeleton lines in the UI. It spans across multiple lines to look good.',
    keyFeatures: ['Feature 1', 'Feature 2', 'Feature 3'],
    ownerId: 'dummy',
    ownerName: 'Loading Owner',
    ownerAvatar: 'https://ui-avatars.com/api/?name=Loading&background=random',
    ownerRating: 5.0,
    isSuperHost: true,
    bookedDates: [],
    isFavorite: false,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
      builder: (context, state) {
        if (state is ItemDetailsError) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(child: Text(state.error)),
          );
        }

        final bool isLoading =
            state is ItemDetailsLoading || state is ItemDetailsInitial;
        final ItemDetailsModel item = isLoading
            ? _dummyItem
            : (state as ItemDetailsLoaded).productDetails;

        return Skeletonizer(
          enabled: isLoading,
          child: Scaffold(
            backgroundColor: AppColors.white,
            //
            bottomNavigationBar: ItemBottomNavBar(item: item),
            //
            body: CustomScrollView(
              slivers: [
                ItemDetailsAppBar(item: item),
                //
                SliverToBoxAdapter(
                  child: Padding(
                    padding: .all(16.r),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        //
                        ItemInfoSection(item: item),
                        //
                        verticalSpace(20),
                        //
                        ItemDescriptionSection(description: item.description),
                        //
                        verticalSpace(20),
                        //
                        ItemFeaturesSection(features: item.keyFeatures),
                        //
                        verticalSpace(24),
                        //
                        OwnerInfoCard(item: item),
                        //
                        verticalSpace(24),
                        //
                        const ItemAvailabilitySection(),
                        //
                        verticalSpace(40),
                        //
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        );
      },
    );
  }
}

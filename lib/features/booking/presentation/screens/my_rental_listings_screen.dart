import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/booking/presentation/widgets/custom_empty_state.dart';
import 'package:rentora/features/booking/presentation/widgets/my_rental_listing_card.dart';

class MyRentalListingsScreen extends StatelessWidget {
  const MyRentalListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final Query<Map<String, dynamic>> query = currentUserId != null
        ? FirebaseFirestore.instance
              .collection('listings')
              .where('ownerId', isEqualTo: currentUserId)
        : FirebaseFirestore.instance.collection('listings');

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBar(text: 'My Listings'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showFeedbackDialog(
            context,
            icon: Icons.add_circle_outline,
            color: AppColors.primaryColor,
            title: 'Add Listing',
            message: 'Add Listing feature opening...',
          );
        },
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.add, color: AppColors.white),
        label: Text(
          'Add Listing',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: query.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading listings: ${snapshot.error}',
                  style: TextStyle(color: AppColors.error, fontSize: 14.sp),
                ),
              );
            }

            final docs = snapshot.data?.docs ?? [];

            if (docs.isEmpty) {
              return const CustomEmptyState(
                icon: Icons.inventory_2_outlined,
                title: 'No Listings Available',
                message: 'You haven\'t added any items for rent yet.',
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              itemCount: docs.length,
              separatorBuilder: (context, index) => verticalSpace(12),
              itemBuilder: (context, index) {
                final data = docs[index].data();
                final title = data['title'] ?? 'Listing Item';
                final category = data['category'] ?? 'General';
                final price = '${data['dailyPrice'] ?? 0} SAR/day';
                final status = data['status'] ?? 'Available';
                final imageUrl =
                    (data['images'] is List &&
                        (data['images'] as List).isNotEmpty)
                    ? data['images'][0]
                    : 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=600';

                return MyRentalListingCard(
                  title: title,
                  category: category,
                  price: price,
                  status: status,
                  imageUrl: imageUrl,
                  onTap: () {
                    context.pushNamed(Routes.incomingRentalRequestScreen);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

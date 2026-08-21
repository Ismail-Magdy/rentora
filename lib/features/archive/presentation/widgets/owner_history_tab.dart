import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/archive/presentation/widgets/owner_earnings_summary_card.dart';
import 'package:rentora/features/archive/presentation/widgets/owner_history_card.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/presentation/widgets/custom_empty_state.dart';

class OwnerHistoryTab extends StatelessWidget {
  final String userId;

  const OwnerHistoryTab({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('ownerId', isEqualTo: userId)
          .snapshots(),
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
        final bookings = docs
            .map((d) => BookingModel.fromJson(d.data()))
            .toList();

        double totalEarnings = 0;
        int activeCount = 0;
        for (var b in bookings) {
          final s = b.status.toLowerCase();
          if (s == 'completed' || s == 'approved' || s == 'active') {
            totalEarnings += b.totalAmount;
          }
          if (s == 'active' || s == 'approved' || s == 'pending') {
            activeCount++;
          }
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: OwnerEarningsSummaryCard(
                totalEarnings: totalEarnings,
                totalRentals: bookings.length,
                activeRentals: activeCount,
              ),
            ),
            if (bookings.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: CustomEmptyState(
                  icon: Icons.inventory_2_outlined,
                  title: 'No Listing Rentals Yet',
                  message:
                      'When people rent your listed items, history and income will appear here.',
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: OwnerHistoryCard(booking: bookings[index]),
                    );
                  }, childCount: bookings.length),
                ),
              ),
          ],
        );
      },
    );
  }
}

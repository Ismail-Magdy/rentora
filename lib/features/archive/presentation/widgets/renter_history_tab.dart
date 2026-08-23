import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/archive/presentation/widgets/renter_history_card.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/presentation/widgets/custom_empty_state.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class RenterHistoryTab extends StatelessWidget {
  final String userId;

  const RenterHistoryTab({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('bookings')
          .where('renterId', isEqualTo: userId)
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
              'Error loading history: ${snapshot.error}',
              style: TextStyle(color: AppColors.error, fontSize: 14.sp),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return CustomEmptyState(
            icon: Icons.history_rounded,
            title: l10n.noRentalHistory,
            message: l10n.noRentalsYet,
          );
        }

        final bookings = docs
            .map((d) => BookingModel.fromJson(d.data()))
            .toList();

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          itemCount: bookings.length,
          separatorBuilder: (context, index) => verticalSpace(12),
          itemBuilder: (context, index) {
            return RenterHistoryCard(booking: bookings[index]);
          },
        );
      },
    );
  }
}

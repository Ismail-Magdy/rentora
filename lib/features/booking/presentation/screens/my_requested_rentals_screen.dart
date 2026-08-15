import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/presentation/widgets/my_requested_rental_card.dart';

class MyRequestedRentalsScreen extends StatelessWidget {
  const MyRequestedRentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    final Query<Map<String, dynamic>> query = currentUserId != null
        ? FirebaseFirestore.instance
            .collection('bookings')
            .where('renterId', isEqualTo: currentUserId)
        : FirebaseFirestore.instance.collection('bookings');

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBar(text: 'My Requested Rentals'),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: query.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading requests: ${snapshot.error}',
                  style: TextStyle(
                    color: AppColors.error,
                    fontSize: 14.sp,
                  ),
                ),
              );
            }

            final docs = snapshot.data?.docs ?? [];

            if (docs.isEmpty) {
              return _buildEmptyState();
            }

            final bookingList = docs.map((doc) {
              final data = doc.data();
              return BookingModel.fromJson(data);
            }).toList();

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              itemCount: bookingList.length,
              separatorBuilder: (context, index) => verticalSpace(12),
              itemBuilder: (context, index) {
                final booking = bookingList[index];
                return MyRequestedRentalCard(
                  title: 'Order #${booking.orderCode}',
                  dates: '${booking.startDate} - ${booking.endDate}',
                  status: _capitalize(booking.status),
                  amount: '${booking.totalAmount} SAR',
                  imageUrl:
                      'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=600',
                  onTap: () {
                    context.pushNamed(
                      Routes.renterOrderDetailsScreen,
                      arguments: booking,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64.sp,
              color: AppColors.grey,
            ),
            verticalSpace(12),
            Text(
              'No Rental Requests',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            verticalSpace(6),
            Text(
              'You haven\'t made any rental requests yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

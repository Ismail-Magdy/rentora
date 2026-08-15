import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class MyRequestedRentalsScreen extends StatelessWidget {
  const MyRequestedRentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rentals = [
      _RentalRequestModel(
        title: 'Canon EOS 250D',
        dates: '15 - 18 October',
        status: 'Pending',
        statusColor: const Color(0xFFB97A00),
        amount: '1,215 SAR',
      ),
      _RentalRequestModel(
        title: 'Sony A7 Camera',
        dates: '5 - 8 November',
        status: 'Accepted',
        statusColor: const Color(0xFF1D8C62),
        amount: '980 SAR',
      ),
      _RentalRequestModel(
        title: 'GoPro Hero 11',
        dates: '22 - 24 November',
        status: 'Rejected',
        statusColor: const Color(0xFFE74C3C),
        amount: '540 SAR',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My Requests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Requested Rentals',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
              verticalSpace(16),
              Expanded(
                child: ListView.separated(
                  itemCount: rentals.length,
                  separatorBuilder: (_, _) => verticalSpace(12),
                  itemBuilder: (context, index) {
                    final item = rentals[index];

                    return _RequestCard(
                      title: item.title,
                      dates: item.dates,
                      status: item.status,
                      statusColor: item.statusColor,
                      amount: item.amount,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RentalRequestModel {
  final String title;
  final String dates;
  final String status;
  final Color statusColor;
  final String amount;

  const _RentalRequestModel({
    required this.title,
    required this.dates,
    required this.status,
    required this.statusColor,
    required this.amount,
  });
}

class _RequestCard extends StatelessWidget {
  final String title;
  final String dates;
  final String status;
  final Color statusColor;
  final String amount;

  const _RequestCard({
    required this.title,
    required this.dates,
    required this.status,
    required this.statusColor,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1516035069371-29a1b244cc32',
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 72,
                height: 72,
                color: AppColors.lightGrey,
                child: const Icon(Icons.camera_alt, color: AppColors.grey),
              ),
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                verticalSpace(8),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 15,
                      color: AppColors.grey,
                    ),
                    horizontalSpace(6),
                    Text(
                      dates,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryColor,
                      ),
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

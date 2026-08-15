import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';

class MyRentalListingsScreen extends StatelessWidget {
  const MyRentalListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listings = [
      _ListingItem(
        title: 'Canon EOS 250D',
        category: 'Camera',
        price: '250 SAR/day',
        status: 'Available',
        statusColor: const Color(0xFF1D8C62),
      ),
      _ListingItem(
        title: 'GoPro Hero 11',
        category: 'Action Cam',
        price: '180 SAR/day',
        status: 'Booked',
        statusColor: const Color(0xFFB97A00),
      ),
      _ListingItem(
        title: 'Sony A7 Camera',
        category: 'Mirrorless',
        price: '320 SAR/day',
        status: 'Unavailable',
        statusColor: const Color(0xFFE74C3C),
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
          'My Listings',
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
                'Rental Listings',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryColor,
                ),
              ),
              verticalSpace(16),
              Expanded(
                child: ListView.separated(
                  itemCount: listings.length,
                  separatorBuilder: (_, _) => verticalSpace(12),
                  itemBuilder: (context, index) {
                    final item = listings[index];
                    return _ListingCard(
                      title: item.title,
                      category: item.category,
                      price: item.price,
                      status: item.status,
                      statusColor: item.statusColor,
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

class _ListingItem {
  final String title;
  final String category;
  final String price;
  final String status;
  final Color statusColor;

  const _ListingItem({
    required this.title,
    required this.category,
    required this.price,
    required this.status,
    required this.statusColor,
  });
}

class _ListingCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final String status;
  final Color statusColor;

  const _ListingCard({
    required this.title,
    required this.category,
    required this.price,
    required this.status,
    required this.statusColor,
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
              width: 74,
              height: 74,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 74,
                height: 74,
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
                verticalSpace(6),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
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

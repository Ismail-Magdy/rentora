import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar_without_leading.dart';
import 'package:rentora/features/archive/presentation/widgets/archive_tab_bar.dart';
import 'package:rentora/features/archive/presentation/widgets/owner_history_tab.dart';
import 'package:rentora/features/archive/presentation/widgets/renter_history_tab.dart';
import 'package:rentora/features/booking/presentation/widgets/custom_empty_state.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null || currentUserId.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: CustomAppBarWithNoLeading(text: 'Archive & Rentals'),
        body: CustomEmptyState(
          icon: Icons.lock_outline_rounded,
          title: 'Login Required',
          message:
              'Please log in to view your past rentals and listing history.',
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBarWithNoLeading(text: 'Archive & Rentals'),
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(8),
            ArchiveTabBar(
              tabController: _tabController,
              tabs: const ['My Rentals', 'My Listings'],
            ),
            verticalSpace(6),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  RenterHistoryTab(userId: currentUserId),
                  OwnerHistoryTab(userId: currentUserId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/features/add_item/presentation/components/review_publish_screen_button.dart';
import 'package:rentora/features/add_item/presentation/components/review_publish_screen_content.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class ReviewAndPublishScreen extends StatefulWidget {
  const ReviewAndPublishScreen({super.key});

  @override
  State<ReviewAndPublishScreen> createState() => _ReviewAndPublishScreenState();
}

class _ReviewAndPublishScreenState extends State<ReviewAndPublishScreen> {
  bool _isLoadingLocation = false;

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemCubit, AddItemState>(
      listener: (context, state) {
        if (state.status == .error) {
          showFeedbackDialog(
            context,
            icon: Icons.error_outline,
            color: AppColors.error,
            title: 'Something Went Wrong',
            message: state.errorMessage ?? 'An error occurred',
          );
        }
        if (state.isPublished) {
          _showSuccessDialog(context);
        }
      },
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final isPublishing = state.status == .loading;
        final isDark = Theme.of(context).brightness == .dark;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Header (unchanged)
                CustomAppBar(text: l10n.addNewListing),
                // Progress (full)
                AddItemProgressBar(
                  title: l10n.reviewPublish,
                  stepNumber: l10n.stepOf("7", "7"),
                ),
                // Content
                ReviewPublishScreenContent(
                  availability: l10n.availability,
                  category: l10n.category,
                  condition: l10n.condition,
                  dailyPrice: l10n.dailyPrice,
                  formatDateAvailableFrom: _formatDate(state.availableFrom),
                  formatDateAvailableTo: _formatDate(state.availableTo),
                  isDark: isDark,
                  isLoadingLocation: _isLoadingLocation,
                  itemDetails: l10n.itemDetails,
                  itemName: l10n.itemName,
                  location: l10n.location,
                  photos: l10n.photos,
                  rentalDetails: l10n.rentalDetails,
                  reviewListing: l10n.reviewListing,
                  reviewListingDesc: l10n.reviewListingDesc,
                  sar: l10n.sar,
                  securityDepositLabel: l10n.securityDepositLabel,
                  state: state,
                  onTap: () async {
                    setState(() {
                      _isLoadingLocation = true;
                    });

                    final uid = FirebaseAuth.instance.currentUser?.uid;
                    String? fetchedLocation;
                    GeoPoint? fetchedGeoPoint;

                    if (uid != null) {
                      try {
                        final doc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .get();
                        if (doc.exists) {
                          fetchedLocation =
                              doc.data()?['locationName'] as String?;
                          fetchedGeoPoint =
                              doc.data()?['location'] as GeoPoint?;
                        }
                      } catch (e) {
                        // ignore
                      }
                    }

                    await Future.delayed(const Duration(milliseconds: 600));

                    if (context.mounted) {
                      if (fetchedLocation != null &&
                          fetchedLocation.isNotEmpty &&
                          fetchedGeoPoint != null) {
                        context.read<AddItemCubit>().updateLocation(
                          fetchedLocation,
                          fetchedGeoPoint,
                        );
                      } else {
                        showFeedbackDialog(
                          context,
                          icon: Icons.warning_amber_rounded,
                          color: AppColors.warning,
                          title: 'Location Not Found',
                          message:
                              'We could not find a saved location in your profile.',
                        );
                      }
                      setState(() {
                        _isLoadingLocation = false;
                      });
                    }
                  },
                ),
                //
                // Publish button
                ReviewPublishScreenButton(
                  isDark: isDark,
                  isPublishing: isPublishing,
                  state: state,
                ),
                //
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    final cubit = context.read<AddItemCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success.withValues(alpha: 0.12),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.success,
                  size: 42,
                ),
              ),
              verticalSpace(20),
              Text(
                'Listing Published',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800),
              ),
              verticalSpace(10),
              Text(
                'Your item is now available for renters to discover',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5.h, color: Color(0xFF6D7478)),
              ),
              verticalSpace(24),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    cubit.reset();

                    Navigator.pop(dialogContext);

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.rootScreen,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontWeight: .w700),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

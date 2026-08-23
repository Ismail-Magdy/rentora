import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_text_field.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({
    super.key,
    required this.searchController,
    required this.onTapCurrentLocation,
    required this.state,
    required this.onPressedSaveLocation,
  });
  final TextEditingController searchController;
  final Function() onTapCurrentLocation;
  final LocationState state;
  final Function() onPressedSaveLocation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Align(
      alignment: .bottomCenter,
      child: Container(
        width: .infinity,
        padding: .symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: .vertical(top: .circular(30.r)),
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            //
            Text(
              l10n.chooseLocationTitle,
              style: TextStyle(fontSize: 20.sp, fontWeight: .bold),
            ),
            //
            verticalSpace(8),
            //
            Text(
              l10n.chooseLocationSubtitle,
              style: TextStyle(color: AppColors.darkGrey, fontSize: 14.sp),
            ),
            //
            verticalSpace(24),
            //
            /// Search Field using our Custom Component
            CustomTextFormField(
              controller: searchController,
              hintText: l10n.searchLocationHint,
              prefixIcon: Icons.search,
              textInputAction: .search,
              onFieldSubmitted: (value) {
                context.read<LocationCubit>().searchLocation(value);
                FocusScope.of(context).unfocus();
              },
            ),
            //
            verticalSpace(16),
            //
            // Or Divider
            Row(
              children: [
                //
                const Expanded(child: Divider()),
                //
                Padding(
                  padding: .symmetric(horizontal: 8.h),
                  child: Text(l10n.or, style: TextStyle(color: AppColors.grey)),
                ),
                //
                const Expanded(child: Divider()),
                //
              ],
            ),
            //
            verticalSpace(16),
            //
            // Use Current Location Button
            GestureDetector(
              onTap: onTapCurrentLocation,
              child: Row(
                children: [
                  //
                  Container(
                    padding: .all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      shape: .circle,
                    ),
                    child: const Icon(
                      Icons.my_location,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  //
                  horizontalSpace(12),
                  //
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      //
                      Text(
                        l10n.useCurrentLocation,
                        style: TextStyle(
                          fontWeight: .bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      //
                      Text(
                        l10n.allowAccessOnce,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      //
                    ],
                  ),
                ],
              ),
            ),
            //
            verticalSpace(24),
            //
            // Confirm Button
            CustomButton(
              text: l10n.confirmLocation,
              isLoading: state is LocationSaving,
              onPressed: onPressedSaveLocation,
            ),
            //
          ],
        ),
      ),
    );
    //
  }
}

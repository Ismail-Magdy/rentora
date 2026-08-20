import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';

class LocationFloatingAddressCard extends StatelessWidget {
  const LocationFloatingAddressCard({
    super.key,
    required this.state,
    required this.cubitSelectedAddress,
  });
  final LocationState state;
  final String? cubitSelectedAddress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.h,
      left: 20.w,
      right: 20.w,
      child: Container(
        padding: .all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: .circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 10.r,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            //
            const Icon(Icons.location_on_outlined, color: Colors.teal),
            //
            horizontalSpace(12),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  //
                  Text(
                    "Choose Delivery Point",
                    style: TextStyle(fontWeight: .bold, fontSize: 14.sp),
                  ),
                  //
                  verticalSpace(4),
                  //
                  // Show loading indicator or the fetched address
                  state is LocationLoading
                      ? SizedBox(
                          height: 12.h,
                          width: 12.w,
                          child: CupertinoActivityIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Text(
                          cubitSelectedAddress ?? "Move map to select location",
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'package:table_calendar/table_calendar.dart';

class ItemAvailabilitySection extends StatelessWidget {
  final ItemDetailsModel item;
  const ItemAvailabilitySection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        //
        Text(
          "Availability",
          style: TextStyle(fontSize: 16.sp, fontWeight: .bold),
        ),
        //
        verticalSpace(12),
        //
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
          ),
          child: TableCalendar(
            firstDay: item.availableFrom ?? DateTime.now(),
            lastDay: item.availableTo ?? DateTime.now().add(const Duration(days: 365)),
            focusedDay: item.availableFrom ?? DateTime.now(),
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            rangeStartDay: item.availableFrom,
            rangeEndDay: item.availableTo,
            availableGestures: AvailableGestures.none, // Disable gestures
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            calendarStyle: CalendarStyle(
              rangeHighlightColor: AppColors.primaryColor.withValues(alpha: 0.2),
              rangeStartDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              rangeEndDecoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}

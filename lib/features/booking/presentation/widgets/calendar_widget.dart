import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Function(DateTime, DateTime) onRangeSelected;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onRangeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: focusedDay,
        rangeSelectionMode: RangeSelectionMode.toggledOn,
        selectedDayPredicate: (day) => isSameDay(selectedStartDate, day),
        rangeStartDay: selectedStartDate,
        rangeEndDay: selectedEndDate,
        onRangeSelected: (start, end, focused) {
          if (start != null && end != null) {
            onRangeSelected(start, end);
          }
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontSize: 18.sp,
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
          selectedDecoration: const BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

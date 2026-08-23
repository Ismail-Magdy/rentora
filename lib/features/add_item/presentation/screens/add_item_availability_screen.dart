import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/custom_button.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/presentation/components/add_item_progress_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/calendar_widget.dart';
import 'package:rentora/features/booking/presentation/widgets/date_range_card.dart';

class AddItemAvailabilityScreen extends StatefulWidget {
  const AddItemAvailabilityScreen({super.key});

  @override
  State<AddItemAvailabilityScreen> createState() =>
      _AddItemAvailabilityScreenState();
}

class _AddItemAvailabilityScreenState extends State<AddItemAvailabilityScreen> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    final state = context.read<AddItemCubit>().state;
    startDate = state.availableFrom;
    endDate = state.availableTo;
    if (startDate != null) {
      focusedDay = startDate!;
    }
  }

  String _formatDateLabel(DateTime? date) {
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
    return '${date.day} ${months[date.month - 1]}';
  }

  void _onNext() {
    final l10n = AppLocalizations.of(context)!;
    if (startDate == null || endDate == null) {
      showFeedbackDialog(
        context,
        icon: Icons.calendar_today_outlined,
        color: AppColors.warning,
        title: l10n.selectDates,
        message: l10n.availabilityRangeRequired,
      );
      return;
    }
    context.read<AddItemCubit>().updateAvailability(startDate!, endDate!);
    Navigator.pushNamed(
      context,
      Routes.reviewScreen,
      arguments: context.read<AddItemCubit>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(text: l10n.addNewListing),
            AddItemProgressBar(
              title: l10n.availability,
              stepNumber: l10n.stepOf("6", "7"),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                children: [
                  Text(
                    l10n.whenAvailable,
                    style: TextStyle(
                      fontSize: 27.sp,
                      height: 1.2.h,
                      fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.black,
                    ),
                  ),
                  verticalSpace(8),
                  Text(
                    l10n.availabilityInstruction,
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.45.h,
                      color: AppColors.grey,
                    ),
                  ),
                  verticalSpace(22),
                  CalendarWidget(
                    focusedDay: focusedDay,
                    selectedStartDate: startDate,
                    selectedEndDate: endDate,
                    onRangeSelected: (start, end) {
                      setState(() {
                        startDate = start;
                        endDate = end;
                      });
                    },
                  ),
                  verticalSpace(16),
                  if (startDate != null && endDate != null) ...[
                    DateRangeCard(
                      pickupDate: _formatDateLabel(startDate),
                      returnDate: _formatDateLabel(endDate),
                      totalDaysText:
                          '${endDate!.difference(startDate!).inDays + 1} ${l10n.daysCapitalized}',
                    ),
                    verticalSpace(16),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: CustomButton(
                text: l10n.continueButton,
                onPressed: _onNext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

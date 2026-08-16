import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/widgets/booking_action_bar.dart';
import 'package:rentora/features/booking/presentation/widgets/calendar_widget.dart';
import 'package:rentora/features/booking/presentation/widgets/date_range_card.dart';
import 'package:rentora/features/booking/presentation/widgets/listing_info_card.dart';

class SelectDatesScreen extends StatefulWidget {
  final String listingId;
  final String ownerId;
  final String renterId;
  final String listingTitle;
  final String listingImageUrl;
  final double dailyPrice;
  final double securityDeposit;

  const SelectDatesScreen({
    super.key,
    this.listingId = '',
    this.ownerId = 'owner_1',
    this.renterId = 'guest_user',
    this.listingTitle = 'Sample Listing',
    this.listingImageUrl =
        'https://www.bing.com/images/search?view=detailV2&ccid=4Lvf%2bvQa&id=2FE6E90002C1FB0F2196841E8651DFAB0B1E0895&thid=OIP.4Lvf-vQaZLbqCCGp5HLLDAHaEK&mediaurl=https%3a%2f%2flaptopmedia.com%2fwp-content%2fuploads%2f2025%2f01%2f5-55.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.e0bbdffaf41a64b6ea0821a9e472cb0c%3frik%3dlQgeC6vfUYYehA%26pid%3dImgRaw%26r%3d0&exph=1080&expw=1920&q=laptop&FORM=IRPRST&ck=A457A70F2DBCF9EAA76D7F6D677E7B48&selectedIndex=0&itb=0',
    this.dailyPrice = 100.0,
    this.securityDeposit = 200.0,
  });

  @override
  State<SelectDatesScreen> createState() => _SelectDatesScreenState();
}

class _SelectDatesScreenState extends State<SelectDatesScreen> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime focusedDay = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: const CustomAppBar(text: 'Select Dates'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
                padding: EdgeInsets.all(16.r),
                children: [
                ListingInfoCard(
                  title: widget.listingTitle,
                  imageUrl: widget.listingImageUrl,
                  dailyPrice: widget.dailyPrice,
                ),
                verticalSpace(16),
                CalendarWidget(
                  focusedDay: focusedDay,
                  selectedStartDate: startDate,
                  selectedEndDate: endDate,
                  onRangeSelected: (start, end) {
                    setState(() {
                      startDate = start;
                      endDate = end;
                    });
                    context.read<BookingCubit>().selectDates(start, end);
                  },
                ),
                verticalSpace(16),
                if (startDate != null && endDate != null) ...[
                  DateRangeCard(
                    pickupDate: _formatDateLabel(startDate),
                    returnDate: _formatDateLabel(endDate),
                    totalDaysText:
                        '${endDate!.difference(startDate!).inDays + 1} Days',
                  ),
                  verticalSpace(16),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: startDate != null && endDate != null
          ? _buildActionBar(context)
          : null,
    );
  }

  Widget _buildActionBar(BuildContext context) {
    final totalDays = endDate!.difference(startDate!).inDays + 1;
    final dailyPrice = widget.dailyPrice;
    final totalAmount = dailyPrice * totalDays;
    final firebaseAuthService = getIt<FirebaseAuthService>();
    final currentUserId =
        firebaseAuthService.getCurrentUserId() ?? widget.renterId;

    return BookingActionBar(
      label: 'Total ($totalDays days)',
      totalText: '${totalAmount.toStringAsFixed(0)} SAR',
      buttonText: 'Confirm Dates',
      buttonWidth: 160.w,
      onPressed: () {
        final bookingCubit = context.read<BookingCubit>();
        context.pushNamed(
          Routes.bookingSummaryScreen,
          arguments: BookingSummaryArgs(
            bookingCubit: bookingCubit,
            listingId: widget.listingId,
            ownerId: widget.ownerId,
            renterId: currentUserId,
            dailyPrice: widget.dailyPrice,
            securityDeposit: widget.securityDeposit,
            listingTitle: widget.listingTitle,
            listingImageUrl: widget.listingImageUrl,
          ),
        );
      },
    );
  }
}

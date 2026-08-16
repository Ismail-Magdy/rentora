import 'package:rentora/features/booking/manager/booking_cubit.dart';

class BookingScreenArgs {
  final String listingId;
  final String ownerId;
  final String renterId;
  final num dailyPrice;
  final num securityDeposit;
  final String listingTitle;
  final String listingImageUrl;

  BookingScreenArgs({
    required this.listingId,
    required this.ownerId,
    required this.renterId,
    required this.dailyPrice,
    required this.securityDeposit,
    required this.listingTitle,
    required this.listingImageUrl,
  });
}

class BookingSummaryArgs {
  final BookingCubit? bookingCubit;
  final String listingId;
  final String ownerId;
  final String renterId;
  final num dailyPrice;
  final num securityDeposit;
  final String listingTitle;
  final String listingImageUrl;

  BookingSummaryArgs({
    this.bookingCubit,
    this.listingId = '1',
    this.ownerId = 'owner_1',
    this.renterId = 'guest_user',
    this.dailyPrice = 100.0,
    this.securityDeposit = 200.0,
    this.listingTitle = 'Sample Listing',
    this.listingImageUrl =
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
  });
}

class BookingSuccessArgs {
  final String orderCode;
  final BookingSummaryArgs bookingSummaryArgs;

  BookingSuccessArgs({
    this.orderCode = 'RNTR-0000',
    BookingSummaryArgs? bookingSummaryArgs,
  }) : bookingSummaryArgs = bookingSummaryArgs ?? BookingSummaryArgs();
}

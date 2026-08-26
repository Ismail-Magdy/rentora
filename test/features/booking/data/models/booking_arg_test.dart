import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';

void main() {
  group('Booking Arguments Tests', () {
    test('BookingScreenArgs correctly stores all properties', () {
      final args = BookingScreenArgs(
        listingId: 'list_1',
        ownerId: 'owner_1',
        renterId: 'renter_1',
        dailyPrice: 100,
        securityDeposit: 50,
        listingTitle: 'DSLR Camera',
        listingImageUrl: 'https://example.com/img.jpg',
      );

      expect(args.listingId, 'list_1');
      expect(args.ownerId, 'owner_1');
      expect(args.renterId, 'renter_1');
      expect(args.dailyPrice, 100);
      expect(args.securityDeposit, 50);
      expect(args.listingTitle, 'DSLR Camera');
      expect(args.listingImageUrl, 'https://example.com/img.jpg');
    });

    test('BookingSummaryArgs defaults and custom values', () {
      final defaultArgs = BookingSummaryArgs();
      expect(defaultArgs.listingId, '1');
      expect(defaultArgs.ownerId, 'owner_1');
      expect(defaultArgs.dailyPrice, 100.0);

      final customArgs = BookingSummaryArgs(
        listingId: 'list_2',
        ownerId: 'owner_2',
        renterId: 'renter_2',
        dailyPrice: 200.0,
      );
      expect(customArgs.listingId, 'list_2');
      expect(customArgs.dailyPrice, 200.0);
    });

    test('BookingSuccessArgs defaults and custom values', () {
      final defaultSuccess = BookingSuccessArgs();
      expect(defaultSuccess.orderCode, 'RNTR-0000');
      expect(defaultSuccess.bookingSummaryArgs.listingId, '1');

      final customSuccess = BookingSuccessArgs(
        orderCode: 'RNTR-9999',
        bookingSummaryArgs: BookingSummaryArgs(listingId: 'custom_id'),
      );
      expect(customSuccess.orderCode, 'RNTR-9999');
      expect(customSuccess.bookingSummaryArgs.listingId, 'custom_id');
    });
  });
}

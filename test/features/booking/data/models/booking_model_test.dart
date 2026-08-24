import 'package:flutter_test/flutter_test.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';

void main() {
  group('BookingModel', () {
    final model = BookingModel(
      bookingId: 'b1',
      orderCode: 'ORD-1',
      listingId: 'l1',
      renterId: 'r1',
      ownerId: 'o1',
      startDate: '2026-01-01',
      endDate: '2026-01-03',
      totalDays: 2,
      dailyPrice: 10.5,
      securityDeposit: 20,
      totalAmount: 41,
      paymentMethod: 'cash',
      handoverMethod: 'meetup',
      status: 'pending',
      createdAt: 'now',
    );

    test('serializes all fields', () {
      expect(BookingModel.fromJson(model.toJson()).toJson(), model.toJson());
    });

    test('uses defaults for missing optional values', () {
      final result = BookingModel.fromJson({});
      expect(result.bookingId, '');
      expect(result.totalDays, 0);
      expect(result.paymentMethod, 'cash');
      expect(result.handoverMethod, 'meetup');
      expect(result.status, 'pending');
    });
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/network/firebase/bookings_firestore_service.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/data/repo/booking_repo_imp.dart';

class MockBookingsFirestoreService extends Mock
    implements BookingsFirestoreService {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockBookingsFirestoreService mockService;
  late BookingRepository repository;

  final tBooking = BookingModel(
    bookingId: 'book_1',
    orderCode: 'RNTR-1001',
    listingId: 'item_1',
    renterId: 'renter_1',
    ownerId: 'owner_1',
    startDate: '2025-05-01',
    endDate: '2025-05-05',
    totalDays: 5,
    dailyPrice: 50,
    securityDeposit: 100,
    totalAmount: 350,
    paymentMethod: 'cash',
    handoverMethod: 'meetup',
    status: 'pending',
    createdAt: '2025-04-20T10:00:00.000',
  );

  setUp(() {
    mockService = MockBookingsFirestoreService();
    repository = BookingRepository(mockService);
  });

  group('BookingRepository Tests', () {
    test('createBooking calls createBookingRequest on service', () async {
      when(
        () => mockService.createBookingRequest(
          bookingId: any(named: 'bookingId'),
          bookingData: any(named: 'bookingData'),
        ),
      ).thenAnswer((_) async {});

      await repository.createBooking(tBooking);

      verify(
        () => mockService.createBookingRequest(
          bookingId: 'book_1',
          bookingData: tBooking.toJson(),
        ),
      ).called(1);
    });

    test('createBooking throws ServerFailure when service throws', () async {
      when(
        () => mockService.createBookingRequest(
          bookingId: any(named: 'bookingId'),
          bookingData: any(named: 'bookingData'),
        ),
      ).thenThrow(Exception('Firestore write failed'));

      expect(
        () => repository.createBooking(tBooking),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('fetchOwnerBookings returns list of BookingModel', () async {
      final mockSnapshot = MockQuerySnapshot();
      final mockDoc = MockQueryDocumentSnapshot();

      when(() => mockDoc.data()).thenReturn(tBooking.toJson());
      when(() => mockSnapshot.docs).thenReturn([mockDoc]);
      when(
        () => mockService.getOwnerBookings(ownerId: 'owner_1'),
      ).thenAnswer((_) async => mockSnapshot);

      final result = await repository.fetchOwnerBookings('owner_1');

      expect(result.length, 1);
      expect(result.first.bookingId, 'book_1');
      expect(result.first.orderCode, 'RNTR-1001');
    });

    test('updateStatus calls updateBookingStatus on service', () async {
      when(
        () => mockService.updateBookingStatus(
          bookingId: 'book_1',
          newStatus: 'accepted',
        ),
      ).thenAnswer((_) async {});

      await repository.updateStatus(bookingId: 'book_1', newStatus: 'accepted');

      verify(
        () => mockService.updateBookingStatus(
          bookingId: 'book_1',
          newStatus: 'accepted',
        ),
      ).called(1);
    });
  });
}

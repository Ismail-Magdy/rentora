import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/data/repo/booking_repo_imp.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

void main() {
  late MockBookingRepository mockRepo;
  late BookingCubit bookingCubit;

  setUpAll(() {
    registerFallbackValue(
      BookingModel(
        bookingId: '',
        orderCode: '',
        listingId: '',
        renterId: '',
        ownerId: '',
        startDate: '',
        endDate: '',
        totalDays: 1,
        dailyPrice: 0,
        securityDeposit: 0,
        totalAmount: 0,
        paymentMethod: '',
        handoverMethod: '',
        status: '',
        createdAt: '',
      ),
    );
  });

  setUp(() {
    mockRepo = MockBookingRepository();
    bookingCubit = BookingCubit(bookingRepository: mockRepo);
  });

  tearDown(() {
    bookingCubit.close();
  });

  group('BookingCubit Tests', () {
    test('initial state is BookingInitial', () {
      expect(bookingCubit.state, isA<BookingInitial>());
    });

    test(
      'selectDates updates internal variables and emits BookingDatesSelected',
      () {
        final start = DateTime(2025, 6, 1);
        final end = DateTime(2025, 6, 5);

        bookingCubit.selectDates(start, end);

        expect(bookingCubit.startDate, start);
        expect(bookingCubit.endDate, end);
        expect(bookingCubit.totalDays, 5);
        expect(bookingCubit.state, isA<BookingDatesSelected>());

        final state = bookingCubit.state as BookingDatesSelected;
        expect(state.startDate, start);
        expect(state.endDate, end);
        expect(state.totalDays, 5);
      },
    );

    blocTest<BookingCubit, BookingState>(
      'submitBooking emits BookingError if dates are null',
      build: () => bookingCubit,
      act: (cubit) => cubit.submitBooking(
        listingId: 'list_1',
        ownerId: 'owner_1',
        renterId: 'renter_1',
        dailyPrice: 100,
        securityDeposit: 50,
      ),
      expect: () => [
        isA<BookingError>().having(
          (s) => s.message,
          'message',
          'Please select dates first',
        ),
      ],
    );

    blocTest<BookingCubit, BookingState>(
      'updateBookingStatus emits [BookingLoading, BookingStatusUpdated] on success',
      build: () {
        when(
          () =>
              mockRepo.updateStatus(bookingId: 'b_123', newStatus: 'accepted'),
        ).thenAnswer((_) async {});
        return bookingCubit;
      },
      act: (cubit) =>
          cubit.updateBookingStatus(bookingId: 'b_123', status: 'accepted'),
      expect: () => [
        isA<BookingLoading>(),
        isA<BookingStatusUpdated>()
            .having((s) => s.bookingId, 'bookingId', 'b_123')
            .having((s) => s.status, 'status', 'accepted'),
      ],
    );

    blocTest<BookingCubit, BookingState>(
      'updateBookingStatus emits [BookingLoading, BookingError] on failure',
      build: () {
        when(
          () =>
              mockRepo.updateStatus(bookingId: 'b_123', newStatus: 'rejected'),
        ).thenThrow(const ServerFailure('Failed to update'));
        return bookingCubit;
      },
      act: (cubit) =>
          cubit.updateBookingStatus(bookingId: 'b_123', status: 'rejected'),
      expect: () => [
        isA<BookingLoading>(),
        isA<BookingError>().having(
          (s) => s.message,
          'message',
          'Failed to update',
        ),
      ],
    );
  });
}

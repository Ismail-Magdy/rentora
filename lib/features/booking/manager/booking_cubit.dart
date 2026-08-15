import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/data/repo/booking_repo_imp.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository bookingRepository;

  BookingCubit({required this.bookingRepository}) : super(BookingInitial());

  DateTime? startDate;
  DateTime? endDate;
  int totalDays = 0;

  void selectDates(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    totalDays = end.difference(start).inDays + 1;
    if (totalDays < 1) totalDays = 1;
    emit(
      BookingDatesSelected(
        startDate: start,
        endDate: end,
        totalDays: totalDays,
      ),
    );
  }

  Future<void> submitBooking({
    required String listingId,
    required String ownerId,
    required String renterId,
    required num dailyPrice,
    required num securityDeposit,
  }) async {
    if (startDate == null || endDate == null) {
      emit(BookingError(message: "Please select dates first"));
      return;
    }

    emit(BookingLoading());

    try {
      final docId = FirebaseFirestore.instance.collection('bookings').doc().id;
      final orderCode =
          "RNTR-${1000 + DateTime.now().millisecondsSinceEpoch % 9000}";

      final totalAmount = (dailyPrice * totalDays) + securityDeposit;

      final booking = BookingModel(
        bookingId: docId,
        orderCode: orderCode,
        listingId: listingId,
        renterId: renterId,
        ownerId: ownerId,
        startDate: startDate!.toIso8601String().split('T')[0],
        endDate: endDate!.toIso8601String().split('T')[0],
        totalDays: totalDays,
        dailyPrice: dailyPrice,
        securityDeposit: securityDeposit,
        totalAmount: totalAmount,
        paymentMethod: "cash",
        handoverMethod: "meetup",
        status: "pending",
        createdAt: DateTime.now().toIso8601String(),
      );

      await bookingRepository.createBooking(booking);

      emit(BookingSuccess(orderCode: orderCode));
    } catch (e) {
      final errorMessage = e is Failure ? e.message : e.toString();
      emit(BookingError(message: errorMessage));
    }
  }
}

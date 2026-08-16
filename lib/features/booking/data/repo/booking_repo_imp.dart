import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/bookings_firestore_service.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';

class BookingRepository {
  final BookingsFirestoreService _bookingsFirestoreService;

  BookingRepository(this._bookingsFirestoreService);

  Future<void> createBooking(BookingModel booking) async {
    try {
      await _bookingsFirestoreService.createBookingRequest(
        bookingId: booking.bookingId,
        bookingData: booking.toJson(),
      );
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }

  Future<List<BookingModel>> fetchOwnerBookings(String ownerId) async {
    try {
      final querySnapshot = await _bookingsFirestoreService.getOwnerBookings(
        ownerId: ownerId,
      );

      return querySnapshot.docs
          .map((doc) => BookingModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }

  Future<void> updateStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    try {
      await _bookingsFirestoreService.updateBookingStatus(
        bookingId: bookingId,
        newStatus: newStatus,
      );
    } catch (e) {
      throw ServerFailure(FirebaseErrorHandler.handle(e));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class BookingsFirestoreService {
  final FirebaseFirestore _firestore;

  BookingsFirestoreService(this._firestore);

  /// Creates a new booking request from a renter to an owner
  Future<void> createBookingRequest({
    required String bookingId,
    required Map<String, dynamic> bookingData,
  }) async {
    await _firestore.collection('bookings').doc(bookingId).set(bookingData);
  }

  /// Fetches all booking requests received by the item owner
  Future<QuerySnapshot<Map<String, dynamic>>> getOwnerBookings({
    required String ownerId,
  }) async {
    return await _firestore
        .collection("bookings")
        .where("ownerId", isEqualTo: ownerId)
        .orderBy("createdAt", descending: true)
        .get();
  }

  /// Updates the booking status ('accepted', 'rejected', 'completed')
  Future<void> updateBookingStatus({
    required String bookingId,
    required String newStatus,
  }) async {
    await _firestore.collection("bookings").doc(bookingId).update({
      "status": newStatus,
    });
  }

  /* 
  CLASS SUMMARY:
  This class manages the entire rental lifecycle. It allows renters to create 
  requests, and allows owners to fetch and update the status of those requests. 
  It acts as the financial and logistical ledger for Rentora transactions.
  */
}

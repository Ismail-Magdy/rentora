import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/errors/firebase_error_handler.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';

class SetupProfileRepo {
  final UsersFirestoreService _usersFirestoreService;

  SetupProfileRepo(this._usersFirestoreService);

  /// Saves the user's selected location data to their Firestore profile.
  /// Takes [userId], [location] as GeoPoint, [address] as String, and [geohash] for queries.
  /// Returns [Right(void)] on success, or [Left(Failure)] on error.
  Future<Either<Failure, void>> saveUserLocation({
    required String userId,
    required GeoPoint location,
    required String address,
    required String geohash,
  }) async {
    try {
      // We pass the specific fields we want to update in the user's document
      await _usersFirestoreService.updateUserProfile(
        userId: userId,
        updatedData: {
          'location': location,
          'locationName':
              address, // Storing the human readable address to display in Home Screen later
          'geohash': geohash,
        },
      );

      // Return Right(null) to indicate success without returning specific data
      return const Right(null);
    } catch (error) {
      // Use our global FirebaseErrorHandler to map the exception to a user-friendly message
      return Left(ServerFailure(FirebaseErrorHandler.handle(error)));
    }
  }

  /// Updates the user's selected interests (categories).
  /// This will be used in the next screen (Choose Interests).
  Future<Either<Failure, void>> saveUserInterests({
    required String userId,
    required List<String> interests,
  }) async {
    try {
      await _usersFirestoreService.updateUserProfile(
        userId: userId,
        updatedData: {'interests': interests},
      );
      return const Right(null);
    } catch (error) {
      return Left(ServerFailure(FirebaseErrorHandler.handle(error)));
    }
  }

  /* 
  CLASS SUMMARY:
  This Repository acts as the Data Layer for the Setup Profile feature.
  It communicates with the `UsersFirestoreService` to update the user's 
  location and interests. It ensures that any exceptions thrown by Firebase 
  are caught and translated into standardized `Failure` objects using the 
  `dartz` package (Either pattern), ensuring the Cubit only deals with clean data or predictable errors.
  */
}

part of 'location_cubit.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

/// Emitted when fetching GPS coordinates or reverse geocoding the address.
class LocationLoading extends LocationState {}

/// Emitted when the user selects a location (either via GPS or manual map drag).
/// Holds the coordinates and the human readable address to display in the UI.
class LocationSelected extends LocationState {
  final double latitude;
  final double longitude;
  final String address;

  LocationSelected({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

/// Emitted when the save request is sent to Firebase.
class LocationSaving extends LocationState {}

/// Emitted when the location is successfully saved in Firestore.
class LocationSavedSuccess extends LocationState {}

/// Emitted when any error occurs (GPS permissions denied, network error, Firebase error).
class LocationError extends LocationState {
  final String error;
  LocationError(this.error);
}

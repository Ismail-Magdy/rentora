import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rentora/features/setup_profile/data/repos/setup_profile_repo.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final SetupProfileRepo _setupProfileRepo;
  final FirebaseAuth _firebaseAuth;

  LocationCubit(this._setupProfileRepo, this._firebaseAuth)
    : super(LocationInitial());

  // Variables to hold the current selected data
  double? selectedLat;
  double? selectedLng;
  String? selectedAddress;

  /// Requests GPS permissions and fetches the current device location.
  Future<void> getCurrentLocation() async {
    emit(LocationLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          LocationError('Location services are disabled. Please enable GPS.'),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError('Location permissions are denied.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          LocationError(
            'Location permissions are permanently denied. Cannot request permissions.',
          ),
        );
        return;
      }

      // Fetch the actual position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Extract address using Geocoding
      await _updateAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      emit(LocationError('Failed to get current location: ${e.toString()}'));
    }
  }

  /// Called whenever the user drags the map to select a custom location.
  Future<void> updateMarkerPosition(double lat, double lng) async {
    emit(LocationLoading());
    await _updateAddressFromCoordinates(lat, lng);
  }

  /// Private helper function to reverse geocode LatLng into a readable address.
  Future<void> _updateAddressFromCoordinates(double lat, double lng) async {
    try {
      selectedLat = lat;
      selectedLng = lng;

      // Reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Constructing a readable address (e.g., "Street Name, City")
        final street = (place.street != null && place.street!.isNotEmpty)
            ? '${place.street}, '
            : '';
        final locality = place.locality ?? '';
        selectedAddress = '$street$locality'.trim();
      } else {
        selectedAddress = 'Unknown Location';
      }

      emit(
        LocationSelected(
          latitude: selectedLat!,
          longitude: selectedLng!,
          address: selectedAddress!,
        ),
      );
    } catch (e) {
      // If geocoding fails, fallback to Unknown Location but keep coordinates
      selectedAddress = 'Unknown Location';
      emit(
        LocationSelected(
          latitude: selectedLat!,
          longitude: selectedLng!,
          address: selectedAddress!,
        ),
      );
    }
  }

  ///  Generates Geohash and saves the location data to Firebase via the Repository.
  Future<void> saveLocation() async {
    if (selectedLat == null || selectedLng == null || selectedAddress == null) {
      emit(LocationError('Please select a location first.'));
      return;
    }

    emit(LocationSaving());

    final String userId = _firebaseAuth.currentUser?.uid ?? '';
    if (userId.isEmpty) {
      emit(LocationError('User authentication error. Please login again'));
      return;
    }

    try {
      // Generate a 7-character geohash (precision 7 is roughly ±76 meters accuracy)
      final geoHasher = GeoHasher();
      final String geohash = geoHasher.encode(
        selectedLng!,
        selectedLat!,
        precision: 7,
      );

      final result = await _setupProfileRepo.saveUserLocation(
        userId: userId,
        location: GeoPoint(selectedLat!, selectedLng!),
        address: selectedAddress!,
        geohash: geohash,
      );

      result.fold(
        (failure) => emit(LocationError(failure.message)),
        (_) => emit(LocationSavedSuccess()),
      );
    } catch (e) {
      emit(LocationError('An unexpected error occurred.'));
    }
  }

  /// Searches for a location by name when the user presses Enter on the keyboard.
  Future<void> searchLocation(String query) async {
    if (query.trim().isEmpty) return;

    emit(LocationLoading());

    try {
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final location = locations.first;
        await _updateAddressFromCoordinates(
          location.latitude,
          location.longitude,
        );
      } else {
        emit(LocationError('Location not found. Try another name'));
      }
    } catch (e) {
      emit(LocationError('Could not find this location.'));
    }
  }

  /* 
  CLASS SUMMARY:
  This Cubit manages the state and business logic for the Location Selection 
  screen. It handles requesting device GPS permissions via `geolocator`, 
  translating coordinates into readable street names using `geocoding`, and 
  encoding the final coordinates into a Geohash before pushing the data 
  to Firestore through the `SetupProfileRepo`.
  */
}

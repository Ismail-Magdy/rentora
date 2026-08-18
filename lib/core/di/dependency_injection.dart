import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rentora/core/network/firebase/bookings_firestore_service.dart';
import 'package:rentora/core/network/firebase/chats_firestore_service.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/listings_firestore_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/core/network/firebase/verifications_firestore_service.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:rentora/features/create_listing/data/repos/listing_repository_impl.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  /// Core Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  /// Firebase Core Instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  /// Firebase Feature Services
  getIt.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(getIt<FirebaseAuth>()),
  );
  getIt.registerLazySingleton<UsersFirestoreService>(
    () => UsersFirestoreService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<VerificationsFirestoreService>(
    () => VerificationsFirestoreService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ListingsFirestoreService>(
    () => ListingsFirestoreService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<BookingsFirestoreService>(
    () => BookingsFirestoreService(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ChatsFirestoreService>(
    () => ChatsFirestoreService(getIt<FirebaseFirestore>()),
  );

  /// Media Services
  getIt.registerLazySingleton<CloudinaryService>(
    () => CloudinaryService(),
  );

  /// Offline Mode
  getIt.registerLazySingleton<NetworkCubit>(() => NetworkCubit());


  // Create Listing Add Iteam

getIt.registerLazySingleton<ListingRepositoryImpl>(
    () => ListingRepositoryImpl(
      getIt<FirebaseFirestore>(),
      getIt<CloudinaryService>(),
    ),
  );

getIt.registerFactory<ListingCubit>(
  () => ListingCubit(
    getIt<ListingRepositoryImpl>(),
    getIt<FirebaseAuth>(),
  ),
);

  // Repository


}
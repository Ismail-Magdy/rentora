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
import 'package:rentora/features/setup_profile/data/repos/setup_profile_repo.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';
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
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());

  /// Offline Mode
  getIt.registerLazySingleton<NetworkCubit>(() => NetworkCubit());

  /// Setup Profile
  getIt.registerLazySingleton<SetupProfileRepo>(
    () => SetupProfileRepo(getIt<UsersFirestoreService>()),
  );

  getIt.registerFactory<LocationCubit>(
    () => LocationCubit(getIt<SetupProfileRepo>(), getIt<FirebaseAuth>()),
  );

  getIt.registerFactory<InterestsCubit>(
    () => InterestsCubit(getIt<SetupProfileRepo>(), getIt<FirebaseAuth>()),
  );

  // Example at Auth Feature To do as this
  // /// Signup
  // getIt.registerLazySingleton<SignupRepo>(() => SignupRepo());
  // getIt.registerFactory<SignupBloc>(() => SignupBloc(getIt<SignupRepo>()));

  // /// Login
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo());
  // getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<LoginRepo>()));

  // /// Forgot Password
  // getIt.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordRepo());
  // getIt.registerFactory<ForgotPasswordBloc>(
  //   () => ForgotPasswordBloc(getIt<ForgotPasswordRepo>()),
  // );
}

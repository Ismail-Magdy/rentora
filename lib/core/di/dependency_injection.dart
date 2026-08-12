import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/core/network/firebase/firestore_service.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  /// Core Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  /// Firebase Instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  /// Network Services
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());

  /// Offline Mode
  getIt.registerLazySingleton<NetworkCubit>(() => NetworkCubit());

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

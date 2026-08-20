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
import 'package:rentora/features/add_item/data/repos/add_item_repository_impl.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/category_details/data/repos/category_details_repo.dart';
import 'package:rentora/features/category_details/data/repos/category_details_repo_impl.dart';
import 'package:rentora/features/category_details/manager/category_details_cubit.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';
import 'package:rentora/features/home/data/repos/home_repo_impl.dart';
import 'package:rentora/features/home/manager/home_cubit.dart';
import 'package:rentora/features/item_details/data/repos/item_details_repo.dart';
import 'package:rentora/features/item_details/data/repos/item_details_repo_impl.dart';
import 'package:rentora/features/item_details/manager/item_details_cubit.dart';
import 'package:rentora/features/setup_profile/data/repos/setup_profile_repo.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';
import 'package:rentora/features/booking/data/repo/booking_repo_imp.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/chat/data/repo/chat_repo_imp.dart';
import 'package:rentora/features/chat/manager/chat_cubit.dart';
import 'package:rentora/features/verification/data/repo/verification_repo.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rentora/features/auth/data/repos/auth_repo.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';

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

  /// auth Feature
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(
      authService: getIt<FirebaseAuthService>(),
      usersService: getIt<UsersFirestoreService>(),
    ),
  );
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));

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

  /// Home
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(getIt<FirebaseFirestore>(), getIt<FirebaseAuth>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));

  /// Item Details
  getIt.registerLazySingleton<ItemDetailsRepo>(
    () => ItemDetailsRepoImpl(FirebaseFirestore.instance),
  );

  getIt.registerFactory<ItemDetailsCubit>(
    () => ItemDetailsCubit(getIt<ItemDetailsRepo>()),
  );

  /// Category Details
  getIt.registerLazySingleton<CategoryDetailsRepo>(
    () => CategoryDetailsRepoImpl(FirebaseFirestore.instance),
  );

  getIt.registerFactory<CategoryDetailsCubit>(
    () => CategoryDetailsCubit(getIt<CategoryDetailsRepo>()),
  );

  /// Booking
  getIt.registerLazySingleton<BookingRepository>(
    () => BookingRepository(getIt<BookingsFirestoreService>()),
  );
  getIt.registerFactory<BookingCubit>(
    () => BookingCubit(bookingRepository: getIt<BookingRepository>()),
  );

  /// Chat
  getIt.registerLazySingleton<ChatRepo>(
    () => ChatRepo(
      getIt<ChatsFirestoreService>(),
      getIt<FirebaseFirestore>(),
      getIt<CloudinaryService>(),
    ),
  );
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepo>()));

  /// Verification
  getIt.registerLazySingleton<VerificationRepo>(
    () => VerificationRepo(
      getIt<CloudinaryService>(),
      getIt<VerificationsFirestoreService>(),
      getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerFactory<VerificationCubit>(
    () => VerificationCubit(
      getIt<VerificationRepo>(),
      getIt<FirebaseAuthService>(),
    ),
  );

  /// Create Listing Add Iteam
  getIt.registerLazySingleton<AddItemRepositoryImpl>(
    () => AddItemRepositoryImpl(
      getIt<FirebaseFirestore>(),
      getIt<CloudinaryService>(),
    ),
  );

  getIt.registerFactory<AddItemCubit>(
    () => AddItemCubit(getIt<AddItemRepositoryImpl>(), getIt<FirebaseAuth>()),
  );
}

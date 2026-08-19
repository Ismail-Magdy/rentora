import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:rentora/core/network/manager/network_state.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/offline_mode_widget.dart';
import 'package:rentora/core/widgets/unknown_route_screen.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_cubit.dart';
import 'package:rentora/features/create_listing/presentation/screens/add_photos_screen.dart';
import 'package:rentora/features/create_listing/presentation/screens/item_details_screen.dart';
import 'package:rentora/features/create_listing/presentation/screens/review_publish_screen.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:rentora/features/auth/presentation/screens/login_screen.dart';
import 'package:rentora/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:rentora/features/auth/presentation/screens/welcome_auth_screen.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
import 'package:rentora/features/booking/data/model/booking_model.dart';
import 'package:rentora/features/booking/manager/booking_cubit.dart';
import 'package:rentora/features/booking/presentation/screens/booking_success_screen.dart';
import 'package:rentora/features/booking/presentation/screens/booking_summary_screen.dart';
import 'package:rentora/features/booking/presentation/screens/incoming_rental_request_screen.dart';
import 'package:rentora/features/booking/presentation/screens/my_rental_listings_screen.dart';
import 'package:rentora/features/booking/presentation/screens/my_requested_rentals_screen.dart';
import 'package:rentora/features/booking/presentation/screens/payment_method_screen.dart';
import 'package:rentora/features/booking/presentation/screens/pickup_options_screen.dart';
import 'package:rentora/features/booking/presentation/screens/renter_order_details_screen.dart';
import 'package:rentora/features/booking/presentation/screens/request_accepted_status_screen.dart';
import 'package:rentora/features/booking/presentation/screens/request_rejected_status_screen.dart';
import 'package:rentora/features/booking/presentation/screens/select_dates_screen.dart';
import 'package:rentora/features/category_details/manager/category_details_cubit.dart';
import 'package:rentora/features/home/manager/home_cubit.dart';
import 'package:rentora/features/category_details/presentation/screens/category_details_screen.dart';
import 'package:rentora/features/home/presentation/screens/home_screen.dart';
import 'package:rentora/features/item_details/manager/item_details_cubit.dart';
import 'package:rentora/features/item_details/presentation/screens/item_details_screen.dart';
import 'package:rentora/features/on_boarding/presentation/screens/on_boarding_screens.dart';
import 'package:rentora/features/root/screens/root_screen.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';
import 'package:rentora/features/setup_profile/presentation/screens/interests_screen.dart';
import 'package:rentora/features/setup_profile/presentation/screens/location_screen.dart';
import 'package:rentora/features/splash/screens/splash_screen.dart';
import 'package:rentora/features/create_listing/presentation/screens/choose_category_screens.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/verification/manager/verification_cubit.dart';
import 'package:rentora/features/verification/data/model/verification_route_args.dart';
import 'package:rentora/features/verification/presentation/screens/verification_face_scan_screen.dart';
import 'package:rentora/features/verification/presentation/screens/verification_id_back_upload_screen.dart';
import 'package:rentora/features/verification/presentation/screens/verification_id_front_upload_screen.dart';
import 'package:rentora/features/verification/presentation/screens/verification_intro_screen.dart';
import 'package:rentora/features/verification/presentation/screens/verification_pending_screen.dart';

class AppRouter {
  /// Function to wrap the screen with NetworkCubit and OfflineModeWidget
  Widget _withNetwork(Widget screen) {
    return BlocProvider.value(
      value: getIt<NetworkCubit>(),
      child: BlocBuilder<NetworkCubit, NetworkState>(
        builder: (context, state) {
          return Stack(
            children: [
              screen,
              if (state is NetworkDisconnected) const OfflineModeWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _withAuth(Widget screen) {
    return _withNetwork(
      BlocProvider(create: (_) => getIt<AuthCubit>(), child: screen),
    );
  }

  Widget _withVerificationCubit(Widget screen, Object? args) {
    if (args is VerificationRouteArgs) {
      return BlocProvider.value(value: args.verificationCubit, child: screen);
    }

    return BlocProvider(
      create: (context) => getIt<VerificationCubit>(),
      child: screen,
    );
  }

  Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// OnBoarding Screens
      case Routes.onBoardingScreens:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreens());
case Routes.categoryScreen:
  return MaterialPageRoute(
    builder: (_) => _withNetwork(
      BlocProvider(
        create: (_) => getIt<ListingCubit>(),
        child: const ChooseCategoryScreen(),
      ),
    ),
  );
  case Routes.itemDetailsScreen:
  final cubit = settings.arguments as ListingCubit;

  return MaterialPageRoute(
    builder: (_) => _withNetwork(
      BlocProvider.value(
        value: cubit,
        child: const ItemDetailsScreen(),
      ),
    ),
  );
  case Routes.addPhotosScreen:
  final cubit = settings.arguments as ListingCubit;

  return MaterialPageRoute(
    builder: (_) => _withNetwork(
      BlocProvider.value(
        value: cubit,
        child: const AddPhotosScreen(),
      ),
    ),
  );
  case Routes.reviewScreen:
  final cubit = settings.arguments as ListingCubit;

  return MaterialPageRoute(
    builder: (_) => _withNetwork(
      BlocProvider.value(
        value: cubit,
        child: const ReviewAndPublishScreen(),
      ),
    ),
  );

      /// Welcome Auth Screen
      case Routes.welcomeAuthScreen:
        return MaterialPageRoute(
          builder: (_) => _withAuth(const WelcomeAuthScreen()),
        );

      /// Sign Up Screen
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => _withAuth(const SignUpScreen()),
        );

      /// Login Screen
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => _withAuth(const LoginScreen()),
        );

      /// Forgot Password Screen
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => _withAuth(const ForgetPasswordScreen()),
        );
      //
      /// Setup Profile
      // Location Screen
      case Routes.locationScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<LocationCubit>(),
              child: const LocationScreen(),
            ),
          ),
        );

      // Interests Screen
      case Routes.interestsScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<InterestsCubit>(),
              child: const InterestsScreen(),
            ),
          ),
        );

      /// Root
      case Routes.rootScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<HomeCubit>()),
                // BlocProvider(
                //   create: (context) => getIt<ChatCubit>(),
                // ),
              ],
              child: const RootScreen(),
            ),
          ),
        );

      /// Home Screen
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      /// Category Details Screen
      case Routes.categoryDetailsScreen:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<CategoryDetailsCubit>(),
              child: CategoryDetailsScreen(categoryName: categoryName),
            ),
          ),
        );

      /// Item Details Screen
      case Routes.itemDetailsScreen:
        final itemId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<ItemDetailsCubit>(),
              child: ItemDetailsScreen(itemId: itemId),
            ),
          ),
        );

      /// Booking Screens
      case Routes.selectedDatesScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<BookingCubit>(),
              child: SelectDatesScreen(
                listingId: args is BookingScreenArgs ? args.listingId : '1',
                dailyPrice: args is BookingScreenArgs
                    ? args.dailyPrice.toDouble()
                    : 100.0,
                listingTitle: args is BookingScreenArgs
                    ? args.listingTitle
                    : 'Sample Listing',
                listingImageUrl: args is BookingScreenArgs
                    ? args.listingImageUrl
                    : 'https://via.placeholder.com/300',
              ),
            ),
          ),
        );

      case Routes.bookingSummaryScreen:
        if (args is BookingSummaryArgs) {
          final cubit = args.bookingCubit ?? getIt<BookingCubit>();

          return MaterialPageRoute(
            builder: (_) => _withNetwork(
              BlocProvider.value(
                value: cubit,
                child: BookingSummaryScreen(args: args),
              ),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => _withNetwork(const UnknownRouteScreen()),
        );

      case Routes.pickupOptionsScreen:
        if (args is BookingSummaryArgs) {
          final cubit = args.bookingCubit ?? getIt<BookingCubit>();

          return MaterialPageRoute(
            builder: (_) => _withNetwork(
              BlocProvider.value(
                value: cubit,
                child: Builder(
                  builder: (context) => PickupOptionsScreen(args: args),
                ),
              ),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => _withNetwork(const UnknownRouteScreen()),
        );

      case Routes.paymentMethodScreen:
        if (args is BookingSummaryArgs) {
          final cubit = args.bookingCubit ?? getIt<BookingCubit>();

          return MaterialPageRoute(
            builder: (_) => _withNetwork(
              BlocProvider.value(
                value: cubit,
                child: PaymentMethodScreen(args: args),
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const UnknownRouteScreen()),
        );

      case Routes.bookingSuccessScreen:
        final successArgs = args is BookingSuccessArgs
            ? args
            : BookingSuccessArgs(
                orderCode: 'RNTR-0000',
                bookingSummaryArgs: BookingSummaryArgs(),
              );
        final cubit =
            successArgs.bookingSummaryArgs.bookingCubit ??
            getIt<BookingCubit>();

        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider.value(
              value: cubit,
              child: BookingSuccessScreen(
                orderCode: successArgs.orderCode,
                bookingArgs: successArgs.bookingSummaryArgs,
              ),
            ),
          ),
        );

      case Routes.renterOrderDetailsScreen:
        final bookingArgs = settings.arguments is BookingSummaryArgs
            ? settings.arguments as BookingSummaryArgs
            : BookingSummaryArgs();
        final cubit = bookingArgs.bookingCubit ?? getIt<BookingCubit>();

        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider.value(
              value: cubit,
              child: RenterOrderDetailsScreen(args: bookingArgs),
            ),
          ),
        );

      case Routes.incomingRentalRequestScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<BookingCubit>(),
              child: IncomingRentalRequestScreen(
                booking: args is BookingModel ? args : null,
              ),
            ),
          ),
        );

      case Routes.requestAcceptedStatusScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<BookingCubit>(),
              child: const RequestAcceptedStatusScreen(),
            ),
          ),
        );

      case Routes.requestRejectedStatusScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<BookingCubit>(),
              child: const RequestRejectedStatusScreen(),
            ),
          ),
        );

      case Routes.myRequestedRentalsScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<BookingCubit>(),
              child: const MyRequestedRentalsScreen(),
            ),
          ),
        );

      case Routes.myRentalListingsScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BlocProvider(
              create: (context) => getIt<BookingCubit>(),
              child: const MyRentalListingsScreen(),
            ),
          ),
        );

      /// Verification Screens
      case Routes.verificationIntroScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            _withVerificationCubit(const VerificationIntroScreen(), args),
          ),
        );

      case Routes.verificationFaceScanScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            _withVerificationCubit(
              BlocConsumer<VerificationCubit, VerificationState>(
                listenWhen: (previous, current) => current is VerificationError,
                listener: (context, state) {
                  if (state is VerificationError) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.error_outline,
                      color: AppColors.error,
                      title: "Scan Failed",
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) => const VerificationFaceScanScreen(),
              ),
              args,
            ),
          ),
        );

      case Routes.verificationIdFrontUploadScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            _withVerificationCubit(
              BlocConsumer<VerificationCubit, VerificationState>(
                listenWhen: (previous, current) => current is VerificationError,
                listener: (context, state) {
                  if (state is VerificationError) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.error_outline,
                      color: AppColors.error,
                      title: "Upload Failed",
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) =>
                    const VerificationIdFrontUploadScreen(),
              ),
              args,
            ),
          ),
        );

      case Routes.verificationIdBackUploadScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            _withVerificationCubit(
              BlocConsumer<VerificationCubit, VerificationState>(
                listenWhen: (previous, current) =>
                    current is VerificationSuccess ||
                    current is VerificationError,
                listener: (context, state) {
                  if (state is VerificationSuccess) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.check_circle_outline,
                      color: AppColors.successDark,
                      title: "Documents Received",
                      message:
                          "Your verification documents were submitted successfully.",
                      onFinish: () => context.pushNamedAndRemoveUntil(
                        Routes.verificationPendingScreen,
                        predicate: (route) => false,
                      ),
                    );
                  }

                  if (state is VerificationError) {
                    showFeedbackDialog(
                      context,
                      icon: Icons.error_outline,
                      color: AppColors.error,
                      title: "Verification Failed",
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) =>
                    const VerificationIdBackUploadScreen(),
              ),
              args,
            ),
          ),
        );

      case Routes.verificationPendingScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            _withVerificationCubit(const VerificationPendingScreen(), args),
          ),
        );

      /// Example of a route that is wrapped with NetworkCubit and OfflineModeWidget
      // /// Welcome AuthScreen
      // case Routes.welcomeAuthScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => _withNetwork(
      //       BlocProvider(
      //         create: (context) => getIt<SocialAuthBloc>(),
      //         child: const WelcomeAuthScreen(),
      //       ),
      //     ),
      //   );

      /// Default Case (Unknown Route)
      default:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const UnknownRouteScreen()),
        );
    }
  }
}

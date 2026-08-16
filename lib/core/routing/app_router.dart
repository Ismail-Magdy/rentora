import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:rentora/core/network/manager/network_state.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/offline_mode_widget.dart';
import 'package:rentora/core/widgets/unknown_route_screen.dart';
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
import 'package:rentora/features/home/manager/home_cubit.dart';
import 'package:rentora/features/home/presentation/screens/category_details_screen.dart';
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

  Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /// Splash Screen
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// OnBoarding Screen
      case Routes.onBoardingScreens:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreens());

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
        return MaterialPageRoute(builder: (_) => const CategoryDetailsScreen());

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

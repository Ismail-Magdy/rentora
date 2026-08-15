import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:rentora/core/network/manager/network_state.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/offline_mode_widget.dart';
import 'package:rentora/core/widgets/unknown_route_screen.dart';
import 'package:rentora/features/booking/data/model/booking_arg.dart';
// BookingSuccessArgs is imported from booking_arg.dart
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
import 'package:rentora/features/on_boarding/presentation/screens/on_boarding_screens.dart';
import 'package:rentora/features/splash/screens/splash_screen.dart';

class AppRouter {
  /// Fucnction to wrap the screen with NetworkCubit and OfflineModeWidget
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

      // ==========================================
      // Renter Flow Routes
      // ==========================================

      /// 1. Select Dates Screen (Booking Screen)
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

      /// 2. Booking Summary Screen
      case Routes.bookingSummaryScreen:
        if (args is BookingSummaryArgs) {
          final cubit = args.bookingCubit ?? getIt<BookingCubit>();

          return MaterialPageRoute(
            builder: (_) => _withNetwork(
              BlocProvider.value(
                value: cubit,
                child: BlocListener<BookingCubit, BookingState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is BookingSuccess) {
                      context.pushNamed(
                        Routes.bookingSuccessScreen,
                        arguments: BookingSuccessArgs(
                          orderCode: state.orderCode,
                          bookingSummaryArgs: args,
                        ),
                      );
                    }

                    if (state is BookingError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  child: BookingSummaryScreen(args: args),
                ),
              ),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => _withNetwork(const UnknownRouteScreen()),
        );

      /// 3. Pickup Options Screen
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

      /// 4. Payment Method Screen
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

      /// 5. Booking Success Screen
      case Routes.bookingSuccessScreen:
        final successArgs = args is BookingSuccessArgs
            ? args
            : BookingSuccessArgs(
                orderCode: 'RNTR-0000',
                bookingSummaryArgs: BookingSummaryArgs(),
              );

        return MaterialPageRoute(
          builder: (_) => _withNetwork(
            BookingSuccessScreen(
              orderCode: successArgs.orderCode,
              bookingArgs: successArgs.bookingSummaryArgs,
            ),
          ),
        );

      /// Renter Order Details
      case Routes.renterOrderDetailsScreen:
        final bookingArgs = settings.arguments is BookingSummaryArgs
            ? settings.arguments as BookingSummaryArgs
            : BookingSummaryArgs();

        return MaterialPageRoute(
          builder: (_) =>
              _withNetwork(RenterOrderDetailsScreen(args: bookingArgs)),
        );

      // ==========================================
      // Owner Flow Routes
      // ==========================================

      /// Incoming Rental Request
      case Routes.incomingRentalRequestScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const IncomingRentalRequestScreen()),
        );

      case Routes.requestAcceptedStatusScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const RequestAcceptedStatusScreen()),
        );

      case Routes.requestRejectedStatusScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const RequestRejectedStatusScreen()),
        );

      // ==========================================
      // Management Routes
      // ==========================================

      case Routes.myRequestedRentalsScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const MyRequestedRentalsScreen()),
        );

      case Routes.myRentalListingsScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const MyRentalListingsScreen()),
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

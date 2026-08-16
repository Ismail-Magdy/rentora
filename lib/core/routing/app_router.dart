import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:rentora/core/network/manager/network_state.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/offline_mode_widget.dart';
import 'package:rentora/core/widgets/unknown_route_screen.dart';
import 'package:rentora/features/on_boarding/presentation/screens/on_boarding_screens.dart';
import 'package:rentora/features/root/presentation/screens/root_screen.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';
import 'package:rentora/features/setup_profile/presentation/screens/interests_screen.dart';
import 'package:rentora/features/setup_profile/presentation/screens/location_screen.dart';
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
        return MaterialPageRoute(builder: (_) => const RootScreen());

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

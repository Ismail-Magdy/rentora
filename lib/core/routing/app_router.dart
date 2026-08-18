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
import 'package:rentora/features/on_boarding/presentation/screens/on_boarding_screens.dart';
import 'package:rentora/features/splash/screens/splash_screen.dart';
import 'package:rentora/features/create_listing/presentation/screens/choose_category_screens.dart';

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

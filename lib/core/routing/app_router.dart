import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/network/manager/network_cubit.dart';
import 'package:rentora/core/network/manager/network_state.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/widgets/offline_mode_widget.dart';
import 'package:rentora/core/widgets/unknown_route_screen.dart';
import 'package:rentora/features/auth/manager/cubit/auth_cubit.dart';
import 'package:rentora/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:rentora/features/auth/presentation/screens/login_screen.dart';
import 'package:rentora/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:rentora/features/auth/presentation/screens/welcome_auth_screen.dart';
import 'package:rentora/features/on_boarding/presentation/screens/on_boarding_screens.dart';
import 'package:rentora/features/splash/screens/splash_screen.dart';

class AppRouter {
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
    return BlocProvider(create: (_) => getIt<AuthCubit>(), child: screen);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onBoardingScreens:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreens());

      case Routes.welcomeAuthScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const WelcomeAuthScreen()),
        );

      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(_withAuth(const SignUpScreen())),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(_withAuth(const LoginScreen())),
        );

      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(_withAuth(const ForgetPasswordScreen())),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => _withNetwork(const UnknownRouteScreen()),
        );
    }
  }
}

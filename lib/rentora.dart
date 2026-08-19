import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/routing/app_router.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/features/create_listing/manager/cubit/listing_cubit.dart';

class Rentora extends StatelessWidget {
  const Rentora({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create: (_) => getIt<ListingCubit>(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Poppins",
            ),
            onGenerateRoute: appRouter.generateRoute,
            initialRoute: Routes.categoryScreen,
          ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Poppins"),
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.forgotPasswordScreen,
        ),
      ),
    );
  }
}

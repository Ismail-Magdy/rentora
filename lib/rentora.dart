import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/routing/app_router.dart';
import 'package:rentora/core/routing/routes.dart';

class Rentora extends StatelessWidget {
  const Rentora({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Poppins"),
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: Routes.welcomeAuthScreen,
        ),
      ),
    );
  }
}

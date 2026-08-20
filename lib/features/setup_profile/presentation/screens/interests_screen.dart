import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/shared_prefrences_helper.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/setup_profile/manager/interests/interests_cubit.dart';
import 'package:rentora/features/setup_profile/presentation/widgets/interests_screen_content.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 24.w),
          child: BlocConsumer<InterestsCubit, InterestsState>(
            listener: (context, state) {
              if (state is InterestsError) {
                //
                showFeedbackDialog(
                  context,
                  icon: Icons.error_outline,
                  color: AppColors.error,
                  title: "Error",
                  message: state.error,
                );
                //
              } else if (state is InterestsSavedSuccess) {
                //
                SharedPrefHelper.setData("hasFinishedSetup", true).then((_) {
                  if (!context.mounted) return;
                  showFeedbackDialog(
                    context,
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                    title: "Success",
                    message: "Your interests have been saved",
                    onFinish: () => context.pushNamedAndRemoveUntil(
                      Routes.rootScreen,
                      predicate: (route) => false,
                    ),
                  );
                });
                //
              }
            },
            builder: (context, state) {
              final cubit = context.read<InterestsCubit>();
              return InterestsScreenContent(cubit: cubit, state: state);
              //
            },
          ),
        ),
      ),
    );
  }
}
// 237
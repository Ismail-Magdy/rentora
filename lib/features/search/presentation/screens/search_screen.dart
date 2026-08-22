import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/search/manager/search_cubit.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/features/search/presentation/widgets/search_input.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Future<void> _performSearch(BuildContext context) async {
    final cubit = context.read<SearchCubit>();

    await cubit.search();

    if (!context.mounted) return;

    if (cubit.state.status == SearchStatus.initial) {
      return;
    }

    context.pushNamed(Routes.searchResultsScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(text: "Search"),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              SearchInput(
                initialValue: context.read<SearchCubit>().state.filter.text,
                onChanged: context.read<SearchCubit>().updateText,
                onSubmitted: (_) => _performSearch(context),
                onFilterPressed: () =>
                    context.pushNamed(Routes.searchFilterScreen),
              ),
              verticalSpace(24),

              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    if (state.status == SearchStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    if (state.status == SearchStatus.error) {
                      return _SearchError(
                        message: state.errorMessage ?? 'Something went wrong.',
                      );
                    }

                    if (state.status == SearchStatus.empty) {
                      return const _EmptySearch();
                    }

                    return const _SearchHint();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64.sp,
            color: AppColors.primaryColor.withValues(alpha: 0.35),
          ),
          SizedBox(height: 14.h),
          Text(
            'Find what you need',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGrey,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Search for items to rent',
            style: TextStyle(fontSize: 13.sp, color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.sp,
            color: AppColors.darkGrey,
          ),
          SizedBox(height: 14.h),
          Text(
            'No items found',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.sp, color: AppColors.darkGrey),
          ),
        ],
      ),
    );
  }
}

class _SearchError extends StatelessWidget {
  final String message;

  const _SearchError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60.sp,
              color: AppColors.error,
            ),
            SizedBox(height: 14.h),
            Text(
              'Search failed',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: AppColors.darkGrey),
            ),
          ],
        ),
      ),
    );
  }
}
// 205
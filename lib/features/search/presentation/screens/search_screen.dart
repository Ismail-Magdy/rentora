import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/features/home/presentation/widgets/home_products_grid.dart';
import 'package:rentora/features/search/manager/search_cubit.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/features/search/presentation/widgets/search_categories.dart';
import 'package:rentora/features/search/presentation/widgets/search_input.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const List<String> _popularCategories = [
    'Cameras',
    'Gaming',
    'Sports',
    'Tools',
    'Books',
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(text: l10n.searchItems),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SearchInput(
                initialValue: context.read<SearchCubit>().state.filter.text,
                onChanged: context.read<SearchCubit>().updateText,
                onSubmitted: (_) => context.read<SearchCubit>().search(),
                onFilterPressed: () => context.pushNamed(
                  Routes.searchFilterScreen,
                  arguments: context.read<SearchCubit>(),
                ),
              ),
            ),
            verticalSpace(8),

            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.status == SearchStatus.loading) {
                    return Skeletonizer(
                      enabled: true,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                          HomeProductsGrid(
                            products: state.results,
                            isLoading: true,
                          ),
                          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
                        ],
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

                  if (state.status == SearchStatus.success) {
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: verticalSpace(8)),
                        HomeProductsGrid(
                          products: state.results,
                          isLoading: false,
                        ),
                        SliverToBoxAdapter(child: verticalSpace(30)),
                      ],
                    );
                  }

                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.categories,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? AppColors.darkTextPrimary
                                : AppColors.black,
                          ),
                        ),
                        verticalSpace(12),
                        SearchCategories(
                          categories: _popularCategories,
                          selectedCategory: state.filter.category,
                          onCategorySelected: (cat) =>
                              context.read<SearchCubit>().updateCategory(cat),
                        ),
                        verticalSpace(40),
                        const _SearchHint(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: 64.sp,
            color: isDark
                ? AppColors.secondaryColor.withValues(alpha: 0.5)
                : AppColors.primaryColor.withValues(alpha: 0.35),
          ),
          SizedBox(height: 14.h),
          Text(
            'Find what you need',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkTextPrimary : AppColors.darkGrey,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Search for items to rent',
            style: TextStyle(
              fontSize: 13.sp,
              color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
            ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.sp,
            color: isDark ? AppColors.darkTextMuted : AppColors.darkGrey,
          ),
          SizedBox(height: 14.h),
          Text(
            'No items found',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkTextPrimary : AppColors.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Try changing your search or filters.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: isDark ? AppColors.darkTextSecondary : AppColors.darkGrey,
            ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                color: isDark ? AppColors.darkTextPrimary : AppColors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// 205
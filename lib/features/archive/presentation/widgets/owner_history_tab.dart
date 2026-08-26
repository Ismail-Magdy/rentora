import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/di/dependency_injection.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/error_screen.dart';
import 'package:rentora/features/archive/manager/archive_cubit.dart';
import 'package:rentora/features/archive/manager/archive_state.dart';
import 'package:rentora/features/booking/presentation/widgets/custom_empty_state.dart';
import 'package:rentora/features/home/presentation/widgets/product_card.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class OwnerHistoryTab extends StatelessWidget {
  final String userId;

  const OwnerHistoryTab({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<ArchiveCubit>()..getMyProducts(),
      child: BlocBuilder<ArchiveCubit, ArchiveState>(
        builder: (context, state) {
          if (state is ArchiveLoading || state is ArchiveInitial) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is ArchiveError) {
            return ErrorScreen();
          }

          if (state is ArchiveLoaded) {
            final products = state.myProducts;

            if (products.isEmpty) {
              return CustomEmptyState(
                icon: Icons.inventory_2_outlined,
                title: l10n.noListingRentals,
                message: l10n
                    .noListingRentalsMessage, // Consider updating localization string key if needed
              );
            }

            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/presentation/widgets/home_products_grid.dart';
import 'package:rentora/features/home/presentation/widgets/home_top_bar.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

import '../../../../helpers/test_helper.dart';

class MockFavCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

Widget createHomeWidgetTestable({
  required Widget child,
  FavoritesCubit? favoritesCubit,
}) {
  final favCubit = favoritesCubit ?? MockFavCubit();
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FavoritesCubit>.value(
        value: favCubit,
        child: Scaffold(body: child),
      ),
    ),
  );
}

void main() {
  late MockFavCubit mockFavCubit;

  setUpAll(() {
    initTestEnvironment();
  });

  setUp(() {
    mockFavCubit = MockFavCubit();
    when(() => mockFavCubit.state).thenReturn(FavoritesInitial());
    when(() => mockFavCubit.isFavorite(any())).thenReturn(false);
    when(() => mockFavCubit.favorites).thenReturn([]);
  });

  group('Home Widgets Tests', () {
    testWidgets('HomeTopBar renders notification icon and search text', (
      tester,
    ) async {
      await tester.pumpWidget(
        createHomeWidgetTestable(
          favoritesCubit: mockFavCubit,
          child: const HomeTopBar(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.text('Search for anything'), findsOneWidget);
    });

    testWidgets('HomeProductsGrid renders product items in CustomScrollView', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(856, 1852);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final products = [
        ProductModel(
          id: 'prod_1',
          name: 'GoPro Hero 11',
          category: 'Cameras',
          price: 35.0,
          rating: 4.8,
          distance: 1.5,
          locationName: 'Cairo',
          imageUrl: 'https://example.com/gopro.jpg',
          ownerId: 'user_1',
        ),
      ];

      await tester.pumpWidget(
        createHomeWidgetTestable(
          favoritesCubit: mockFavCubit,
          child: CustomScrollView(
            slivers: [HomeProductsGrid(products: products)],
          ),
        ),
      );
      await tester.pump();

      expect(find.text('GoPro Hero 11'), findsOneWidget);
    });
  });
}

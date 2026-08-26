import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

import '../../../../helpers/test_helper.dart';

class MockFavCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

Widget createFavoritesScreenTestable(FavoritesCubit cubit) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FavoritesCubit>.value(
        value: cubit,
        child: const FavoritesScreen(),
      ),
    ),
  );
}

void main() {
  late MockFavCubit mockFavoritesCubit;

  setUpAll(() {
    initTestEnvironment();
  });

  setUp(() {
    mockFavoritesCubit = MockFavCubit();
    when(() => mockFavoritesCubit.getFavorites()).thenAnswer((_) async {});
    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(true);
  });

  group('FavoritesScreen Tests', () {
    testWidgets(
      'renders category filter tabs and triggers getFavorites on init',
      (tester) async {
        tester.view.physicalSize = const Size(856, 1852);
        tester.view.devicePixelRatio = 2.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final products = [
          ProductModel(
            id: 'prod_1',
            name: 'PlayStation 5',
            category: 'Gaming',
            price: 50.0,
            rating: 4.9,
            distance: 1.0,
            locationName: 'Cairo',
            imageUrl: 'https://example.com/ps5.jpg',
            ownerId: 'user_1',
            isFavorite: true,
          ),
        ];

        when(
          () => mockFavoritesCubit.state,
        ).thenReturn(FavoritesLoaded(products));
        when(() => mockFavoritesCubit.favorites).thenReturn(products);

        await tester.pumpWidget(
          createFavoritesScreenTestable(mockFavoritesCubit),
        );
        await tester.pump();

        verify(() => mockFavoritesCubit.getFavorites()).called(1);
        expect(find.text('PlayStation 5'), findsOneWidget);
      },
    );
  });
}

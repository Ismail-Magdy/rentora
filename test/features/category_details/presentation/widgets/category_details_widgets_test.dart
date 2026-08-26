import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/category_details/presentation/widgets/category_details_screen_content.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';
import '../../../../helpers/test_helper.dart';

class MockFavoritesCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

Widget createCategoryDetailsTestable({
  required Widget child,
  required FavoritesCubit favoritesCubit,
}) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FavoritesCubit>.value(
        value: favoritesCubit,
        child: child,
      ),
    ),
  );
}

void main() {
  setUpAll(() {
    initTestEnvironment();
  });

  late MockFavoritesCubit mockFavoritesCubit;

  setUp(() {
    mockFavoritesCubit = MockFavoritesCubit();
    when(() => mockFavoritesCubit.state).thenReturn(FavoritesInitial());
    when(() => mockFavoritesCubit.isFavorite(any())).thenReturn(false);
    when(() => mockFavoritesCubit.favorites).thenReturn([]);
  });

  group('CategoryDetailsScreenContent Tests', () {
    testWidgets(
      'renders empty state when displayList is empty and not loading',
      (tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          createCategoryDetailsTestable(
            favoritesCubit: mockFavoritesCubit,
            child: const CategoryDetailsScreenContent(
              categoryName: 'Cameras',
              isLoading: false,
              displayList: [],
            ),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('No Products Found'), findsOneWidget);
      },
    );

    testWidgets(
      'renders grid with product items when displayList is not empty',
      (tester) async {
        final products = [
          ProductModel(
            id: 'prod_1',
            name: 'Nikon D850',
            category: 'Cameras',
            price: 60.0,
            rating: 4.9,
            distance: 1.5,
            locationName: 'Alexandria',
            imageUrl: 'https://example.com/nikon.jpg',
            ownerId: 'user_1',
          ),
        ];

        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(
          createCategoryDetailsTestable(
            favoritesCubit: mockFavoritesCubit,
            child: CategoryDetailsScreenContent(
              categoryName: 'Cameras',
              isLoading: false,
              displayList: products,
            ),
          ),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Nikon D850'), findsOneWidget);
      },
    );
  });
}

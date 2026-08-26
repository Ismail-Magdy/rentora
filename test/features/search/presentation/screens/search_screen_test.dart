import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/home/presentation/widgets/home_products_grid.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/features/search/presentation/screens/search_screen.dart';
import 'package:rentora/features/search/presentation/widgets/search_categories.dart';
import 'package:rentora/features/search/presentation/widgets/search_input.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  late MockSearchCubit mockSearchCubit;

  setUpAll(() {
    initTestEnvironment();
  });

  setUp(() {
    mockSearchCubit = MockSearchCubit();
  });

  final testProducts = [
    createDummyProduct(id: 'cam_1', name: 'Sony A7IV', category: 'Cameras'),
  ];

  group('SearchScreen Widget Tests', () {
    testWidgets('renders SearchInput, Categories, and Hint in initial state', (
      tester,
    ) async {
      when(() => mockSearchCubit.state).thenReturn(const SearchState());

      await tester.pumpApp(const SearchScreen(), searchCubit: mockSearchCubit);

      expect(find.byType(SearchInput), findsOneWidget);
      expect(find.text('Categories'), findsOneWidget);
      expect(find.byType(SearchCategories), findsOneWidget);
      expect(find.text('Find what you need'), findsOneWidget);
      expect(find.text('Search for items to rent'), findsOneWidget);
    });

    testWidgets('renders loading state with CustomScrollView', (tester) async {
      when(
        () => mockSearchCubit.state,
      ).thenReturn(const SearchState(status: SearchStatus.loading));

      await tester.pumpApp(const SearchScreen(), searchCubit: mockSearchCubit);

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets(
      'renders HomeProductsGrid when status is SearchStatus.success',
      (tester) async {
        when(() => mockSearchCubit.state).thenReturn(
          SearchState(status: SearchStatus.success, results: testProducts),
        );

        await tester.pumpApp(
          const SearchScreen(),
          searchCubit: mockSearchCubit,
        );

        expect(find.byType(HomeProductsGrid), findsOneWidget);
        expect(find.text('Sony A7IV'), findsOneWidget);
      },
    );

    testWidgets('renders _EmptySearch when status is SearchStatus.empty', (
      tester,
    ) async {
      when(
        () => mockSearchCubit.state,
      ).thenReturn(const SearchState(status: SearchStatus.empty, results: []));

      await tester.pumpApp(const SearchScreen(), searchCubit: mockSearchCubit);

      expect(find.text('No items found'), findsOneWidget);
      expect(find.text('Try changing your search or filters.'), findsOneWidget);
    });

    testWidgets('renders _SearchError when status is SearchStatus.error', (
      tester,
    ) async {
      const errorMsg = 'Failed to retrieve listings.';
      when(() => mockSearchCubit.state).thenReturn(
        const SearchState(status: SearchStatus.error, errorMessage: errorMsg),
      );

      await tester.pumpApp(const SearchScreen(), searchCubit: mockSearchCubit);

      expect(find.text('Search failed'), findsOneWidget);
      expect(find.text(errorMsg), findsOneWidget);
    });

    testWidgets('triggers updateText on typing in search input', (
      tester,
    ) async {
      when(() => mockSearchCubit.state).thenReturn(const SearchState());
      when(() => mockSearchCubit.updateText(any())).thenReturn(null);

      await tester.pumpApp(const SearchScreen(), searchCubit: mockSearchCubit);

      final searchTextField = find.byType(TextField);
      expect(searchTextField, findsOneWidget);

      await tester.enterText(searchTextField, 'MacBook');
      await tester.pump();

      verify(() => mockSearchCubit.updateText('MacBook')).called(1);
    });

    testWidgets('triggers updateCategory when a category chip is tapped', (
      tester,
    ) async {
      when(() => mockSearchCubit.state).thenReturn(const SearchState());
      when(() => mockSearchCubit.updateCategory(any())).thenReturn(null);

      await tester.pumpApp(const SearchScreen(), searchCubit: mockSearchCubit);

      final cameraChip = find.text('Cameras');
      expect(cameraChip, findsOneWidget);

      await tester.tap(cameraChip);
      await tester.pump();

      verify(() => mockSearchCubit.updateCategory('Cameras')).called(1);
    });
  });
}

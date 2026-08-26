import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/home/presentation/widgets/home_products_grid.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/features/search/presentation/screens/search_results_screen.dart';

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
    createDummyProduct(
      id: 'item_1',
      name: 'Professional Video Camera',
      category: 'Cameras',
      price: 99.0,
    ),
    createDummyProduct(
      id: 'item_2',
      name: 'Wireless Controller',
      category: 'Gaming',
      price: 25.0,
    ),
  ];

  group('SearchResultsScreen Widget Tests', () {
    testWidgets(
      'renders HomeProductsGrid with products when status is SearchStatus.success',
      (tester) async {
        when(() => mockSearchCubit.state).thenReturn(
          SearchState(status: SearchStatus.success, results: testProducts),
        );

        await tester.pumpApp(
          const SearchResultsScreen(),
          searchCubit: mockSearchCubit,
        );

        expect(find.byType(HomeProductsGrid), findsOneWidget);
        expect(find.text('Professional Video Camera'), findsOneWidget);
        expect(find.text('Wireless Controller'), findsOneWidget);
      },
    );

    testWidgets('renders empty view when status is SearchStatus.empty', (
      tester,
    ) async {
      when(
        () => mockSearchCubit.state,
      ).thenReturn(const SearchState(status: SearchStatus.empty, results: []));

      await tester.pumpApp(
        const SearchResultsScreen(),
        searchCubit: mockSearchCubit,
      );

      expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
      expect(find.text('No Products Found'), findsOneWidget);
      expect(find.text('Try changing your search or filters.'), findsOneWidget);
    });

    testWidgets(
      'renders error view and triggers search on retry when status is SearchStatus.error',
      (tester) async {
        const errorMsg = 'Failed to fetch items from server.';
        when(() => mockSearchCubit.state).thenReturn(
          const SearchState(status: SearchStatus.error, errorMessage: errorMsg),
        );
        when(() => mockSearchCubit.search()).thenAnswer((_) async {});

        await tester.pumpApp(
          const SearchResultsScreen(),
          searchCubit: mockSearchCubit,
        );

        expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
        expect(find.text('Something went wrong'), findsOneWidget);
        expect(find.text(errorMsg), findsOneWidget);
        expect(find.text('Retry'), findsOneWidget);

        await tester.tap(find.text('Retry'));
        await tester.pump();

        verify(() => mockSearchCubit.search()).called(1);
      },
    );

    testWidgets('renders loading state with CustomScrollView', (tester) async {
      when(() => mockSearchCubit.state).thenReturn(
        const SearchState(status: SearchStatus.loading, results: []),
      );

      await tester.pumpApp(
        const SearchResultsScreen(),
        searchCubit: mockSearchCubit,
      );

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('renders empty view when status is SearchStatus.initial', (
      tester,
    ) async {
      when(() => mockSearchCubit.state).thenReturn(
        const SearchState(status: SearchStatus.initial, results: []),
      );

      await tester.pumpApp(
        const SearchResultsScreen(),
        searchCubit: mockSearchCubit,
      );

      expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
    });

    testWidgets(
      'renders CircularProgressIndicator when status is SearchStatus.smartSearchLoading',
      (tester) async {
        when(() => mockSearchCubit.state).thenReturn(
          const SearchState(status: SearchStatus.smartSearchLoading),
        );

        await tester.pumpApp(
          const SearchResultsScreen(),
          searchCubit: mockSearchCubit,
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets('pops screen when back icon is pressed in AppBar', (
      tester,
    ) async {
      when(
        () => mockSearchCubit.state,
      ).thenReturn(const SearchState(status: SearchStatus.initial));

      await tester.pumpApp(
        Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchResultsScreen()),
            ),
            child: const Text('Open Results'),
          ),
        ),
        searchCubit: mockSearchCubit,
      );

      await tester.tap(find.text('Open Results'));
      await tester.pumpAndSettle();

      expect(find.byType(SearchResultsScreen), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(SearchResultsScreen), findsNothing);
      expect(find.text('Open Results'), findsOneWidget);
    });
  });
}

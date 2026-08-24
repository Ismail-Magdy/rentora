import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/features/search/presentation/screens/search_filter_screen.dart';
import 'package:rentora/features/search/presentation/widgets/search_filters.dart';

import '../../../../helpers/test_helper.dart';

void main() {
  late MockSearchCubit mockSearchCubit;

  setUpAll(() {
    initTestEnvironment();
  });

  setUp(() {
    mockSearchCubit = MockSearchCubit();
  });

  group('SearchFilterScreen Widget Tests', () {
    testWidgets(
      'renders AppBar with Filters title, Clear button, and Apply button',
      (tester) async {
        when(() => mockSearchCubit.state).thenReturn(const SearchState());

        await tester.pumpApp(
          const SearchFilterScreen(),
          searchCubit: mockSearchCubit,
        );

        expect(find.text('Filters'), findsOneWidget);
        expect(find.text('Clear'), findsOneWidget);
        expect(find.text('Apply Filters'), findsOneWidget);
        expect(find.byType(SearchFilters), findsOneWidget);
      },
    );

    testWidgets('calls clearFilters when Clear button is pressed', (
      tester,
    ) async {
      when(() => mockSearchCubit.state).thenReturn(const SearchState());
      when(() => mockSearchCubit.clearFilters()).thenReturn(null);

      await tester.pumpApp(
        const SearchFilterScreen(),
        searchCubit: mockSearchCubit,
      );

      await tester.tap(find.text('Clear'));
      await tester.pump();

      verify(() => mockSearchCubit.clearFilters()).called(1);
    });

    testWidgets(
      'calls applyFilters and pops when Apply Filters button is pressed',
      (tester) async {
        when(() => mockSearchCubit.state).thenReturn(const SearchState());
        when(() => mockSearchCubit.applyFilters()).thenAnswer((_) async {});

        await tester.pumpApp(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchFilterScreen()),
              ),
              child: const Text('Open Filter'),
            ),
          ),
          searchCubit: mockSearchCubit,
        );

        await tester.tap(find.text('Open Filter'));
        await tester.pumpAndSettle();

        expect(find.byType(SearchFilterScreen), findsOneWidget);

        await tester.tap(find.text('Apply Filters'));
        await tester.pumpAndSettle();

        verify(() => mockSearchCubit.applyFilters()).called(1);
        expect(find.byType(SearchFilterScreen), findsNothing);
        expect(find.text('Open Filter'), findsOneWidget);
      },
    );
  });
}

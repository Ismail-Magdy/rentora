import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/search/data/models/search_filter_model.dart';
import 'package:rentora/features/search/data/repos/search_repo.dart';
import 'package:rentora/features/search/manager/search_cubit.dart';
import 'package:rentora/features/search/manager/search_state.dart';

import '../../../helpers/test_helper.dart';

void main() {
  late MockSearchRepo mockSearchRepo;
  late SearchCubit searchCubit;

  final dummyProducts = [
    createDummyProduct(id: '1', name: 'Camera 1'),
    createDummyProduct(id: '2', name: 'Camera 2'),
  ];

  setUpAll(() {
    registerFallbackValue(const SearchFilterModel());
  });

  setUp(() {
    mockSearchRepo = MockSearchRepo();
    searchCubit = SearchCubit(mockSearchRepo);
  });

  tearDown(() {
    searchCubit.close();
  });

  group('SearchCubit Tests', () {
    test('initial state should have default SearchState', () {
      expect(searchCubit.state.status, equals(SearchStatus.initial));
      expect(searchCubit.state.filter.isEmpty, isTrue);
      expect(searchCubit.state.results, isEmpty);
      expect(searchCubit.state.errorMessage, isNull);
    });

    group('updateText', () {
      blocTest<SearchCubit, SearchState>(
        'emits loading then success when non-empty text is provided',
        setUp: () {
          when(
            () => mockSearchRepo.searchListings(any()),
          ).thenAnswer((_) async => Right(dummyProducts));
        },
        build: () => searchCubit,
        act: (cubit) => cubit.updateText('Camera'),
        expect: () => [
          predicate<SearchState>(
            (s) =>
                s.filter.text == 'Camera' && s.status == SearchStatus.initial,
          ),
          predicate<SearchState>(
            (s) =>
                s.filter.text == 'Camera' && s.status == SearchStatus.loading,
          ),
          predicate<SearchState>(
            (s) =>
                s.filter.text == 'Camera' &&
                s.status == SearchStatus.success &&
                s.results.length == 2,
          ),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'resets to initial state when text is cleared and filter is empty',
        build: () => searchCubit,
        act: (cubit) => cubit.updateText('   '),
        expect: () => [
          predicate<SearchState>(
            (s) =>
                s.filter.text == null &&
                s.status == SearchStatus.initial &&
                s.results.isEmpty,
          ),
        ],
      );
    });

    group('updateCategory', () {
      blocTest<SearchCubit, SearchState>(
        'emits loading then success when category is set',
        setUp: () {
          when(
            () => mockSearchRepo.searchListings(any()),
          ).thenAnswer((_) async => Right(dummyProducts));
        },
        build: () => searchCubit,
        act: (cubit) => cubit.updateCategory('Gaming'),
        expect: () => [
          predicate<SearchState>(
            (s) =>
                s.filter.category == 'Gaming' &&
                s.status == SearchStatus.initial,
          ),
          predicate<SearchState>(
            (s) =>
                s.filter.category == 'Gaming' &&
                s.status == SearchStatus.loading,
          ),
          predicate<SearchState>(
            (s) =>
                s.filter.category == 'Gaming' &&
                s.status == SearchStatus.success &&
                s.results.length == 2,
          ),
        ],
      );
    });

    group('filter parameter updates', () {
      blocTest<SearchCubit, SearchState>(
        'updateMinPrice updates filter minPrice',
        build: () => searchCubit,
        act: (cubit) => cubit.updateMinPrice(50.0),
        expect: () => [
          predicate<SearchState>((s) => s.filter.minPrice == 50.0),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'updateMaxPrice updates filter maxPrice',
        build: () => searchCubit,
        act: (cubit) => cubit.updateMaxPrice(200.0),
        expect: () => [
          predicate<SearchState>((s) => s.filter.maxPrice == 200.0),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'updateLocation updates filter location',
        build: () => searchCubit,
        act: (cubit) => cubit.updateLocation('Cairo'),
        expect: () => [
          predicate<SearchState>((s) => s.filter.location == 'Cairo'),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'updateCondition updates filter condition',
        build: () => searchCubit,
        act: (cubit) => cubit.updateCondition('New'),
        expect: () => [
          predicate<SearchState>((s) => s.filter.condition == 'New'),
        ],
      );
    });

    group('search', () {
      blocTest<SearchCubit, SearchState>(
        'emits initial and empty results when filter isEmpty is true',
        build: () => searchCubit,
        act: (cubit) => cubit.search(),
        expect: () => [
          predicate<SearchState>(
            (s) => s.status == SearchStatus.initial && s.results.isEmpty,
          ),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'emits loading then empty when repo returns empty product list',
        setUp: () {
          when(
            () => mockSearchRepo.searchListings(any()),
          ).thenAnswer((_) async => const Right([]));
        },
        seed: () =>
            const SearchState(filter: SearchFilterModel(text: 'UnknownItem')),
        build: () => searchCubit,
        act: (cubit) => cubit.search(),
        expect: () => [
          predicate<SearchState>((s) => s.status == SearchStatus.loading),
          predicate<SearchState>(
            (s) => s.status == SearchStatus.empty && s.results.isEmpty,
          ),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'emits loading then error when repo returns Failure',
        setUp: () {
          when(() => mockSearchRepo.searchListings(any())).thenAnswer(
            (_) async => const Left(ServerFailure('Connection error')),
          );
        },
        seed: () =>
            const SearchState(filter: SearchFilterModel(text: 'Camera')),
        build: () => searchCubit,
        act: (cubit) => cubit.search(),
        expect: () => [
          predicate<SearchState>((s) => s.status == SearchStatus.loading),
          predicate<SearchState>(
            (s) =>
                s.status == SearchStatus.error &&
                s.errorMessage == 'Connection error',
          ),
        ],
      );
    });

    group('applyFilters and clearFilters', () {
      blocTest<SearchCubit, SearchState>(
        'applyFilters executes search',
        setUp: () {
          when(
            () => mockSearchRepo.searchListings(any()),
          ).thenAnswer((_) async => Right(dummyProducts));
        },
        seed: () =>
            const SearchState(filter: SearchFilterModel(category: 'Gaming')),
        build: () => searchCubit,
        act: (cubit) => cubit.applyFilters(),
        expect: () => [
          predicate<SearchState>((s) => s.status == SearchStatus.loading),
          predicate<SearchState>((s) => s.status == SearchStatus.success),
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'clearFilters resets to initial empty SearchState',
        seed: () => SearchState(
          status: SearchStatus.success,
          filter: const SearchFilterModel(text: 'Sony', category: 'Cameras'),
          results: dummyProducts,
        ),
        build: () => searchCubit,
        act: (cubit) => cubit.clearFilters(),
        expect: () => [
          predicate<SearchState>(
            (s) =>
                s.status == SearchStatus.initial &&
                s.filter.isEmpty &&
                s.results.isEmpty &&
                s.errorMessage == null,
          ),
        ],
      );
    });
  });
}

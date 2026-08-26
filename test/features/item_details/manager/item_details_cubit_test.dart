import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/item_details/data/models/item_details_model.dart';
import 'package:rentora/features/item_details/data/repos/item_details_repo.dart';
import 'package:rentora/features/item_details/manager/item_details_cubit.dart';

class MockItemDetailsRepo extends Mock implements ItemDetailsRepo {}

void main() {
  late MockItemDetailsRepo mockRepo;
  late ItemDetailsCubit cubit;

  final tDetails = ItemDetailsModel(
    id: 'prod_1',
    name: 'Sony Camera',
    price: 50.0,
    rating: 4.8,
    distance: 2.0,
  );

  setUp(() {
    mockRepo = MockItemDetailsRepo();
    cubit = ItemDetailsCubit(mockRepo);
  });

  tearDown(() {
    cubit.close();
  });

  group('ItemDetailsCubit Tests', () {
    test('initial state is ItemDetailsInitial', () {
      expect(cubit.state, isA<ItemDetailsInitial>());
    });

    blocTest<ItemDetailsCubit, ItemDetailsState>(
      'emits [ItemDetailsLoading, ItemDetailsLoaded] on success',
      build: () {
        when(
          () => mockRepo.getItemDetails('prod_1'),
        ).thenAnswer((_) async => Right(tDetails));
        return cubit;
      },
      act: (cubit) => cubit.getItemDetails('prod_1'),
      expect: () => [
        isA<ItemDetailsLoading>(),
        isA<ItemDetailsLoaded>().having(
          (s) => s.productDetails.name,
          'name',
          'Sony Camera',
        ),
      ],
      verify: (_) {
        expect(cubit.productDetails, tDetails);
      },
    );

    blocTest<ItemDetailsCubit, ItemDetailsState>(
      'emits [ItemDetailsLoading, ItemDetailsError] on failure',
      build: () {
        when(
          () => mockRepo.getItemDetails('prod_1'),
        ).thenAnswer((_) async => const Left(ServerFailure('Item not found')));
        return cubit;
      },
      act: (cubit) => cubit.getItemDetails('prod_1'),
      expect: () => [
        isA<ItemDetailsLoading>(),
        isA<ItemDetailsError>().having(
          (s) => s.error,
          'error',
          'Item not found',
        ),
      ],
    );
  });
}

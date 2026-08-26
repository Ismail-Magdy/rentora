import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/archive/manager/archive_cubit.dart';
import 'package:rentora/features/archive/manager/archive_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

void main() {
  late MockHomeRepo mockHomeRepo;
  late ArchiveCubit archiveCubit;

  setUp(() {
    mockHomeRepo = MockHomeRepo();
    archiveCubit = ArchiveCubit(mockHomeRepo);
  });

  tearDown(() {
    archiveCubit.close();
  });

  final tProducts = [
    ProductModel(
      id: 'prod_1',
      name: 'Drill Machine',
      category: 'Tools',
      price: 25.0,
      rating: 4.5,
      distance: 1.2,
      locationName: 'Cairo',
      imageUrl: 'https://example.com/drill.jpg',
      ownerId: 'user_1',
    ),
  ];

  group('ArchiveCubit Tests', () {
    test('initial state is ArchiveInitial', () {
      expect(archiveCubit.state, equals(ArchiveInitial()));
    });

    blocTest<ArchiveCubit, ArchiveState>(
      'emits [ArchiveLoading, ArchiveLoaded] when getMyProducts succeeds',
      build: () {
        when(
          () => mockHomeRepo.getProducts(onlyCurrentUser: true),
        ).thenAnswer((_) async => Right(tProducts));
        return archiveCubit;
      },
      act: (cubit) => cubit.getMyProducts(),
      expect: () => [ArchiveLoading(), ArchiveLoaded(myProducts: tProducts)],
      verify: (_) {
        verify(() => mockHomeRepo.getProducts(onlyCurrentUser: true)).called(1);
      },
    );

    blocTest<ArchiveCubit, ArchiveState>(
      'emits [ArchiveLoading, ArchiveError] when getMyProducts fails',
      build: () {
        when(() => mockHomeRepo.getProducts(onlyCurrentUser: true)).thenAnswer(
          (_) async =>
              const Left(ServerFailure('Failed to fetch user products')),
        );
        return archiveCubit;
      },
      act: (cubit) => cubit.getMyProducts(),
      expect: () => [
        ArchiveLoading(),
        const ArchiveError('Failed to fetch user products'),
      ],
    );
  });
}

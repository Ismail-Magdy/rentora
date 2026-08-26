import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';
import 'package:rentora/features/home/manager/home_cubit.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

class MockHomeRepo extends Mock implements HomeRepo {}

void main() {
  late MockHomeRepo repo;
  setUp(() => repo = MockHomeRepo());

  blocTest<HomeCubit, HomeState>(
    'loads categories, products, and location',
    build: () {
      when(
        () => repo.getUserCategories(),
      ).thenAnswer((_) async => const Right(['Camera']));
      when(
        () => repo.getProducts(excludeCurrentUser: any(named: 'excludeCurrentUser')),
      ).thenAnswer(
        (_) async => Right([
          ProductModel(
            id: '1',
            name: 'x',
            category: 'Camera',
            price: 1,
            rating: 4,
            distance: 1,
            imageUrl: 'x',
          ),
        ]),
      );
      when(
        () => repo.getUserLocation(),
      ).thenAnswer((_) async => const Right(null));
      return HomeCubit(repo);
    },
    act: (cubit) => cubit.getHomeData(),
    expect: () => [isA<HomeLoading>(), isA<HomeLoaded>()],
  );

  blocTest<HomeCubit, HomeState>(
    'emits error when categories fail',
    build: () {
      when(
        () => repo.getUserCategories(),
      ).thenAnswer((_) async => Left(ServerFailure('failed')));
      return HomeCubit(repo);
    },
    act: (cubit) => cubit.getHomeData(),
    expect: () => [isA<HomeLoading>(), isA<HomeError>()],
  );
}

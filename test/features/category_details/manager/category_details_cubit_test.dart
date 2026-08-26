import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/category_details/data/repos/category_details_repo.dart';
import 'package:rentora/features/category_details/manager/category_details_cubit.dart';
import 'package:rentora/features/category_details/manager/category_details_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

class MockCategoryDetailsRepo extends Mock implements CategoryDetailsRepo {}

void main() {
  late MockCategoryDetailsRepo mockRepo;
  late CategoryDetailsCubit cubit;

  final tProducts = [
    ProductModel(
      id: 'prod_1',
      name: 'Sony Camera',
      category: 'Cameras',
      price: 50.0,
      rating: 4.8,
      distance: 2.0,
      locationName: 'Cairo',
      imageUrl: 'https://example.com/cam.jpg',
      ownerId: 'user_1',
    ),
  ];

  setUp(() {
    mockRepo = MockCategoryDetailsRepo();
    cubit = CategoryDetailsCubit(mockRepo);
  });

  tearDown(() {
    cubit.close();
  });

  group('CategoryDetailsCubit Tests', () {
    test('initial state is CategoryDetailsInitial', () {
      expect(cubit.state, isA<CategoryDetailsInitial>());
    });

    blocTest<CategoryDetailsCubit, CategoryDetailsState>(
      'emits [CategoryDetailsLoading, CategoryDetailsLoaded] on successful fetch',
      build: () {
        when(
          () => mockRepo.getCategoryProducts('Cameras'),
        ).thenAnswer((_) async => Right(tProducts));
        return cubit;
      },
      act: (cubit) => cubit.getProductsByCategory('Cameras'),
      expect: () => [
        isA<CategoryDetailsLoading>(),
        isA<CategoryDetailsLoaded>().having(
          (s) => s.products,
          'products',
          tProducts,
        ),
      ],
      verify: (_) {
        expect(cubit.products, tProducts);
      },
    );

    blocTest<CategoryDetailsCubit, CategoryDetailsState>(
      'emits [CategoryDetailsLoading, CategoryDetailsError] on failure',
      build: () {
        when(() => mockRepo.getCategoryProducts('Cameras')).thenAnswer(
          (_) async => const Left(ServerFailure('Category not found')),
        );
        return cubit;
      },
      act: (cubit) => cubit.getProductsByCategory('Cameras'),
      expect: () => [
        isA<CategoryDetailsLoading>(),
        isA<CategoryDetailsError>().having(
          (s) => s.error,
          'error',
          'Category not found',
        ),
      ],
    );
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/add_item/data/models/add_item_model.dart';
import 'package:rentora/features/add_item/data/repos/add_item_repository_impl.dart';
import 'package:rentora/features/add_item/manager/add_item_cubit.dart';
import 'package:rentora/features/add_item/manager/add_item_state.dart';

class MockAddItemRepository extends Mock implements AddItemRepositoryImpl {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  late MockAddItemRepository mockRepository;
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late AddItemCubit cubit;

  setUpAll(() {
    registerFallbackValue(
      AddItemModel(
        id: '',
        userId: '',
        category: '',
        title: '',
        description: '',
        condition: '',
        dailyPrice: 0,
        securityDeposit: 0,
        location: '',
        imageUrls: const [],
        availableFrom: DateTime.now(),
        availableTo: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    mockRepository = MockAddItemRepository();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    cubit = AddItemCubit(mockRepository, mockAuth);
  });

  tearDown(() {
    cubit.close();
  });

  group('AddItemCubit - Field Updates', () {
    test('initial state is correct', () {
      expect(cubit.state, const AddItemState());
    });

    test('setMainPhoto updates mainPhoto', () {
      final photo = XFile('main.jpg');
      cubit.setMainPhoto(photo);
      expect(cubit.state.mainPhoto, photo);
    });

    test('updateCategory updates categoryId', () {
      cubit.updateCategory('cat_1');
      expect(cubit.state.categoryId, 'cat_1');
    });

    test('updateTitle updates title', () {
      cubit.updateTitle('Sony Alpha');
      expect(cubit.state.title, 'Sony Alpha');
    });

    test('updateDescription updates description', () {
      cubit.updateDescription('Camera for rent');
      expect(cubit.state.description, 'Camera for rent');
    });

    test('updateCondition updates condition', () {
      cubit.updateCondition('Like New');
      expect(cubit.state.condition, 'Like New');
    });

    test('updateDailyPrice and updateSecurityDeposit update prices', () {
      cubit.updateDailyPrice(50.0);
      cubit.updateSecurityDeposit(150.0);
      expect(cubit.state.dailyPrice, 50.0);
      expect(cubit.state.securityDeposit, 150.0);
    });

    test('updateRating and updateLocation update correctly', () {
      cubit.updateRating(4.9);
      cubit.updateLocation('Giza', const GeoPoint(29.9, 31.2));
      expect(cubit.state.rating, 4.9);
      expect(cubit.state.location, 'Giza');
      expect(cubit.state.locationGeoPoint, const GeoPoint(29.9, 31.2));
    });

    test('updateAvailability updates date range', () {
      final from = DateTime(2025, 5, 1);
      final to = DateTime(2025, 5, 10);
      cubit.updateAvailability(from, to);
      expect(cubit.state.availableFrom, from);
      expect(cubit.state.availableTo, to);
    });

    test('toggleKeyFeature adds and removes features', () {
      cubit.toggleKeyFeature('4K Video');
      expect(cubit.state.keyFeatures, ['4K Video']);

      cubit.toggleKeyFeature('4K Video');
      expect(cubit.state.keyFeatures, isEmpty);
    });

    test('toggleAgreedToTerms toggles boolean', () {
      expect(cubit.state.agreedToTerms, false);
      cubit.toggleAgreedToTerms();
      expect(cubit.state.agreedToTerms, true);
    });

    test(
      'addImage, removeImage, replaceImage, and setImages work as expected',
      () {
        final img1 = XFile('img1.jpg');
        final img2 = XFile('img2.jpg');
        final img3 = XFile('img3.jpg');

        cubit.addImage(img1);
        cubit.addImage(img2);
        expect(cubit.state.images, [img1, img2]);

        cubit.replaceImage(1, img3);
        expect(cubit.state.images, [img1, img3]);

        cubit.removeImage(0);
        expect(cubit.state.images, [img3]);

        cubit.setImages([img1, img2]);
        expect(cubit.state.images, [img1, img2]);
      },
    );

    test('reset restores initial state', () {
      cubit.updateTitle('Test');
      cubit.reset();
      expect(cubit.state, const AddItemState());
    });
  });

  group('loadListingForEdit', () {
    final testModel = AddItemModel(
      id: 'item_100',
      userId: 'user_1',
      category: 'Electronics',
      title: 'Sony Camera',
      description: 'Super clear',
      condition: 'Mint',
      dailyPrice: 40.0,
      securityDeposit: 100.0,
      location: 'Cairo',
      locationGeoPoint: const GeoPoint(30.0, 31.0),
      rating: 4.8,
      keyFeatures: const ['Feature1', 'Feature2', 'Feature3'],
      availableFrom: DateTime(2025, 1, 1),
      availableTo: DateTime(2025, 1, 10),
      imageUrls: const ['https://img.com/1.jpg'],
      createdAt: DateTime(2025, 1, 1),
    );

    blocTest<AddItemCubit, AddItemState>(
      'emits success with loaded listing data',
      build: () {
        when(
          () => mockRepository.fetchListing('item_100'),
        ).thenAnswer((_) async => testModel);
        return cubit;
      },
      act: (cubit) => cubit.loadListingForEdit('item_100'),
      expect: () => [
        const AddItemState(status: AddItemStatus.loading),
        AddItemState(
          categoryId: 'Electronics',
          title: 'Sony Camera',
          description: 'Super clear',
          condition: 'Mint',
          dailyPrice: 40.0,
          securityDeposit: 100.0,
          location: 'Cairo',
          locationGeoPoint: const GeoPoint(30.0, 31.0),
          rating: 4.8,
          keyFeatures: const ['Feature1', 'Feature2', 'Feature3'],
          availableFrom: DateTime(2025, 1, 1),
          availableTo: DateTime(2025, 1, 10),
          existingImageUrls: const ['https://img.com/1.jpg'],
          isEditMode: true,
          listingId: 'item_100',
          images: const [],
          status: AddItemStatus.success,
        ),
      ],
    );

    blocTest<AddItemCubit, AddItemState>(
      'emits error when fetchListing fails',
      build: () {
        when(
          () => mockRepository.fetchListing('item_100'),
        ).thenThrow(Exception('Failed to load'));
        return cubit;
      },
      act: (cubit) => cubit.loadListingForEdit('item_100'),
      expect: () => [
        const AddItemState(status: AddItemStatus.loading),
        const AddItemState(
          status: AddItemStatus.error,
          errorMessage: 'Exception: Failed to load',
        ),
      ],
    );
  });

  group('publishListing', () {
    blocTest<AddItemCubit, AddItemState>(
      'emits error when state is invalid (missing photos)',
      build: () => cubit,
      act: (cubit) => cubit.publishListing(),
      expect: () => [
        const AddItemState(
          status: AddItemStatus.error,
          errorMessage: 'Please add at least one photo',
        ),
      ],
    );

    blocTest<AddItemCubit, AddItemState>(
      'emits error when user is not authenticated',
      setUp: () {
        when(() => mockAuth.currentUser).thenReturn(null);
      },
      build: () => cubit,
      seed: () => AddItemState(
        mainPhoto: XFile('photo.jpg'),
        categoryId: 'Electronics',
        title: 'Camera',
        description: 'Pro DSLR',
        condition: 'Good',
        dailyPrice: 50.0,
        securityDeposit: 100.0,
        keyFeatures: const ['f1', 'f2', 'f3'],
        availableFrom: DateTime(2025, 1, 1),
        availableTo: DateTime(2025, 1, 10),
      ),
      act: (cubit) => cubit.publishListing(),
      expect: () => [
        isA<AddItemState>().having(
          (s) => s.status,
          'status',
          AddItemStatus.loading,
        ),
        isA<AddItemState>()
            .having((s) => s.status, 'status', AddItemStatus.error)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('User not authenticated'),
            ),
      ],
    );

    blocTest<AddItemCubit, AddItemState>(
      'emits success and isPublished when validation passes and save succeeds',
      setUp: () {
        when(() => mockAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('user_123');
        when(
          () => mockRepository.saveListing(
            listing: any(named: 'listing'),
            newImages: any(named: 'newImages'),
            existingImageUrls: any(named: 'existingImageUrls'),
          ),
        ).thenAnswer((_) async {});
      },
      build: () => cubit,
      seed: () => AddItemState(
        mainPhoto: XFile('photo.jpg'),
        categoryId: 'Electronics',
        title: 'Camera',
        description: 'Pro DSLR',
        condition: 'Good',
        dailyPrice: 50.0,
        securityDeposit: 100.0,
        keyFeatures: const ['f1', 'f2', 'f3'],
        availableFrom: DateTime(2025, 1, 1),
        availableTo: DateTime(2025, 1, 10),
      ),
      act: (cubit) => cubit.publishListing(),
      expect: () => [
        isA<AddItemState>().having(
          (s) => s.status,
          'status',
          AddItemStatus.loading,
        ),
        isA<AddItemState>()
            .having((s) => s.status, 'status', AddItemStatus.success)
            .having((s) => s.isPublished, 'isPublished', true),
      ],
    );
  });
}

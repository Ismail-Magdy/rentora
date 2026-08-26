import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/core/network/firebase/cloudinary_service.dart';
import 'package:rentora/features/add_item/data/models/add_item_model.dart';
import 'package:rentora/features/add_item/data/repos/add_item_repository_impl.dart';

class MockCloudinaryService extends Mock implements CloudinaryService {}

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockCloudinaryService mockCloudinaryService;
  late MockFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockDocumentReference mockDocumentReference;
  late MockDocumentSnapshot mockDocumentSnapshot;
  late AddItemRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(File('dummy_path'));
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockCloudinaryService = MockCloudinaryService();
    mockFirestore = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();

    when(
      () => mockFirestore.collection(any()),
    ).thenReturn(mockCollectionReference);
    when(
      () => mockCollectionReference.doc(any()),
    ).thenReturn(mockDocumentReference);

    repository = AddItemRepositoryImpl(mockFirestore, mockCloudinaryService);
  });

  group('fetchListing', () {
    test('returns AddItemModel when document exists', () async {
      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);
      when(() => mockDocumentSnapshot.exists).thenReturn(true);
      when(() => mockDocumentSnapshot.id).thenReturn('item_1');
      when(() => mockDocumentSnapshot.data()).thenReturn({
        'userId': 'user_1',
        'category': 'Electronics',
        'title': 'Camera',
        'description': 'DSLR Camera',
        'condition': 'New',
        'dailyPrice': 50.0,
        'securityDeposit': 100.0,
        'location': 'Cairo',
        'locationGeoPoint': const GeoPoint(30.0, 31.0),
        'rating': 4.5,
        'keyFeatures': ['4K', 'Lens'],
        'availableFrom': '2025-01-01T00:00:00.000',
        'availableTo': '2025-01-10T00:00:00.000',
        'imageUrls': ['https://img.com/1.jpg'],
        'createdAt': '2025-01-01T00:00:00.000',
        'isAvailable': true,
      });

      final result = await repository.fetchListing('item_1');

      expect(result.id, 'item_1');
      expect(result.title, 'Camera');
      expect(result.dailyPrice, 50.0);
    });

    test('throws ServerFailure when document does not exist', () async {
      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);
      when(() => mockDocumentSnapshot.exists).thenReturn(false);

      expect(
        () => repository.fetchListing('missing_item'),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('saveListing', () {
    final testModel = AddItemModel(
      id: '',
      userId: 'user_1',
      category: 'Electronics',
      title: 'Camera',
      description: 'DSLR',
      condition: 'New',
      dailyPrice: 50.0,
      securityDeposit: 100.0,
      location: 'Cairo',
      imageUrls: const ['https://img.com/1.jpg'],
      availableFrom: DateTime(2025, 1, 1),
      availableTo: DateTime(2025, 1, 10),
      createdAt: DateTime(2025, 1, 1),
    );

    test('adds new listing to products collection when id is empty', () async {
      when(
        () => mockCollectionReference.add(any()),
      ).thenAnswer((_) async => mockDocumentReference);

      await repository.saveListing(listing: testModel);

      verify(() => mockFirestore.collection('products')).called(1);
      verify(() => mockCollectionReference.add(any())).called(1);
    });

    test(
      'updates existing listing when id is present and uploads images',
      () async {
        final existingModel = AddItemModel(
          id: 'item_123',
          userId: 'user_1',
          category: 'Electronics',
          title: 'Camera',
          description: 'DSLR',
          condition: 'New',
          dailyPrice: 50.0,
          securityDeposit: 100.0,
          location: 'Cairo',
          imageUrls: const ['https://img.com/1.jpg'],
          availableFrom: DateTime(2025, 1, 1),
          availableTo: DateTime(2025, 1, 10),
          createdAt: DateTime(2025, 1, 1),
        );
        when(
          () => mockDocumentReference.update(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockCloudinaryService.uploadImage(any()),
        ).thenAnswer((_) async => 'https://uploaded.url/img.jpg');

        await repository.saveListing(
          listing: existingModel,
          newImages: [XFile('test_path.jpg')],
          existingImageUrls: ['https://old.url/1.jpg'],
        );

        verify(() => mockCloudinaryService.uploadImage(any())).called(1);
        verify(() => mockDocumentReference.update(any())).called(1);
      },
    );
  });
}

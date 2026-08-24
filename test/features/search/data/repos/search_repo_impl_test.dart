import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/errors/failure.dart';
import 'package:rentora/features/search/data/models/search_filter_model.dart';
import 'package:rentora/features/search/data/repos/search_repo_impl.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockProductsCollection;
  late MockCollectionReference mockListingsCollection;
  late SearchRepoImpl searchRepo;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockProductsCollection = MockCollectionReference();
    mockListingsCollection = MockCollectionReference();
    searchRepo = SearchRepoImpl(mockFirestore);

    when(
      () => mockFirestore.collection('products'),
    ).thenReturn(mockProductsCollection);
    when(
      () => mockFirestore.collection('listings'),
    ).thenReturn(mockListingsCollection);
  });

  MockQueryDocumentSnapshot createMockDoc(
    String id,
    Map<String, dynamic> data,
  ) {
    final doc = MockQueryDocumentSnapshot();
    when(() => doc.id).thenReturn(id);
    when(() => doc.data()).thenReturn(data);
    return doc;
  }

  group('SearchRepoImpl Tests', () {
    final doc1 = createMockDoc('doc1', {
      'name': 'Sony Alpha Camera',
      'category': 'Cameras',
      'price': 50.0,
      'locationName': 'Maadi, Cairo',
      'imageUrl': 'https://example.com/sony.jpg',
      'rating': 4.5,
      'distance': 2.0,
    });

    final doc2 = createMockDoc('doc2', {
      'name': 'PlayStation 5 Console',
      'category': 'Gaming',
      'price': 100.0,
      'locationName': 'Zamalek, Cairo',
      'imageUrl': 'https://example.com/ps5.jpg',
      'rating': 4.9,
      'distance': 5.0,
    });

    final doc3 = createMockDoc('doc3', {
      'name': 'Mountain Bike',
      'category': 'Sports',
      'price': 20.0,
      'locationName': 'Alexandria',
      'imageUrl': 'https://example.com/bike.jpg',
      'rating': 4.2,
      'distance': 10.0,
    });

    test(
      'should return all products when filter has no specific constraints',
      () async {
        final snapshot = MockQuerySnapshot();
        when(() => snapshot.docs).thenReturn([doc1, doc2, doc3]);
        when(
          () => mockProductsCollection.get(),
        ).thenAnswer((_) async => snapshot);

        final result = await searchRepo.searchListings(
          const SearchFilterModel(),
        );

        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should succeed'),
          (products) => expect(products.length, equals(3)),
        );
      },
    );

    test(
      'should filter products by keyword text in name, category, or location',
      () async {
        final snapshot = MockQuerySnapshot();
        when(() => snapshot.docs).thenReturn([doc1, doc2, doc3]);
        when(
          () => mockProductsCollection.get(),
        ).thenAnswer((_) async => snapshot);

        final result = await searchRepo.searchListings(
          const SearchFilterModel(text: 'Sony'),
        );

        expect(result.isRight(), isTrue);
        result.fold((failure) => fail('Should succeed'), (products) {
          expect(products.length, equals(1));
          expect(products.first.name, equals('Sony Alpha Camera'));
        });
      },
    );

    test('should filter products by category', () async {
      final snapshot = MockQuerySnapshot();
      when(() => snapshot.docs).thenReturn([doc1, doc2, doc3]);
      when(
        () => mockProductsCollection.get(),
      ).thenAnswer((_) async => snapshot);

      final result = await searchRepo.searchListings(
        const SearchFilterModel(category: 'Gaming'),
      );

      expect(result.isRight(), isTrue);
      result.fold((failure) => fail('Should succeed'), (products) {
        expect(products.length, equals(1));
        expect(products.first.name, equals('PlayStation 5 Console'));
      });
    });

    test('should filter products by minPrice and maxPrice', () async {
      final snapshot = MockQuerySnapshot();
      when(() => snapshot.docs).thenReturn([doc1, doc2, doc3]);
      when(
        () => mockProductsCollection.get(),
      ).thenAnswer((_) async => snapshot);

      final result = await searchRepo.searchListings(
        const SearchFilterModel(minPrice: 30, maxPrice: 60),
      );

      expect(result.isRight(), isTrue);
      result.fold((failure) => fail('Should succeed'), (products) {
        expect(products.length, equals(1));
        expect(products.first.id, equals('doc1'));
      });
    });

    test('should filter products by location', () async {
      final snapshot = MockQuerySnapshot();
      when(() => snapshot.docs).thenReturn([doc1, doc2, doc3]);
      when(
        () => mockProductsCollection.get(),
      ).thenAnswer((_) async => snapshot);

      final result = await searchRepo.searchListings(
        const SearchFilterModel(location: 'Alexandria'),
      );

      expect(result.isRight(), isTrue);
      result.fold((failure) => fail('Should succeed'), (products) {
        expect(products.length, equals(1));
        expect(products.first.name, equals('Mountain Bike'));
      });
    });

    test(
      'should fallback to listings collection if products collection is empty',
      () async {
        final emptySnapshot = MockQuerySnapshot();
        when(() => emptySnapshot.docs).thenReturn([]);
        when(
          () => mockProductsCollection.get(),
        ).thenAnswer((_) async => emptySnapshot);

        final listingsSnapshot = MockQuerySnapshot();
        when(() => listingsSnapshot.docs).thenReturn([doc2]);
        when(
          () => mockListingsCollection.get(),
        ).thenAnswer((_) async => listingsSnapshot);

        final result = await searchRepo.searchListings(
          const SearchFilterModel(),
        );

        expect(result.isRight(), isTrue);
        result.fold((failure) => fail('Should succeed'), (products) {
          expect(products.length, equals(1));
          expect(products.first.id, equals('doc2'));
        });
        verify(() => mockListingsCollection.get()).called(1);
      },
    );

    test('should return ServerFailure on FirebaseException', () async {
      when(() => mockProductsCollection.get()).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Permission denied'),
      );

      final result = await searchRepo.searchListings(const SearchFilterModel());

      expect(result.isLeft(), isTrue);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, contains('Permission denied'));
      }, (products) => fail('Should fail'));
    });

    test('should return ServerFailure on generic exception', () async {
      when(
        () => mockProductsCollection.get(),
      ).thenThrow(Exception('Network error'));

      final result = await searchRepo.searchListings(const SearchFilterModel());

      expect(result.isLeft(), isTrue);
      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, equals('Failed to search products.'));
      }, (products) => fail('Should fail'));
    });
  });
}

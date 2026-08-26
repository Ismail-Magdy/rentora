import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/category_details/data/repos/category_details_repo_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirestore mockFirestore;
  late MockCollectionReference mockCollectionReference;
  late MockQuery mockQuery;
  late MockQuerySnapshot mockQuerySnapshot;
  late MockQueryDocumentSnapshot mockDoc;
  late CategoryDetailsRepoImpl repo;

  setUp(() {
    mockFirestore = MockFirestore();
    mockCollectionReference = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockDoc = MockQueryDocumentSnapshot();

    when(
      () => mockFirestore.collection('products'),
    ).thenReturn(mockCollectionReference);
    when(
      () => mockCollectionReference.where(
        'category',
        isEqualTo: any(named: 'isEqualTo'),
      ),
    ).thenReturn(mockQuery);

    repo = CategoryDetailsRepoImpl(mockFirestore);
  });

  group('CategoryDetailsRepoImpl Tests', () {
    test('returns products list on successful query', () async {
      when(() => mockDoc.id).thenReturn('prod_1');
      when(() => mockDoc.data()).thenReturn({
        'title': 'Sony Camera',
        'category': 'Cameras',
        'dailyPrice': 50.0,
        'rating': 4.8,
        'location': 'Cairo',
        'imageUrls': ['https://example.com/cam.jpg'],
        'userId': 'user_1',
      });
      when(() => mockQuerySnapshot.docs).thenReturn([mockDoc]);
      when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

      final result = await repo.getCategoryProducts('Cameras');

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should be right'), (products) {
        expect(products.length, 1);
        expect(products.first.id, 'prod_1');
        expect(products.first.name, 'Sony Camera');
      });
    });

    test('returns ServerFailure when Firestore throws exception', () async {
      when(() => mockQuery.get()).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'Read error'),
      );

      final result = await repo.getCategoryProducts('Cameras');

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure.message, 'Read error'),
        (_) => fail('Should be left'),
      );
    });
  });
}

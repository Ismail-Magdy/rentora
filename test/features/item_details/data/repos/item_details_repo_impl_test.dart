import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/item_details/data/repos/item_details_repo_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirestore mockFirestore;
  late MockCollectionReference productsCollection;
  late MockCollectionReference usersCollection;
  late MockDocumentReference productDocRef;
  late MockDocumentReference userDocRef;
  late MockDocumentSnapshot productDocSnapshot;
  late MockDocumentSnapshot userDocSnapshot;
  late ItemDetailsRepoImpl repo;

  setUp(() {
    mockFirestore = MockFirestore();
    productsCollection = MockCollectionReference();
    usersCollection = MockCollectionReference();
    productDocRef = MockDocumentReference();
    userDocRef = MockDocumentReference();
    productDocSnapshot = MockDocumentSnapshot();
    userDocSnapshot = MockDocumentSnapshot();

    when(
      () => mockFirestore.collection('products'),
    ).thenReturn(productsCollection);
    when(() => mockFirestore.collection('users')).thenReturn(usersCollection);
    when(() => productsCollection.doc(any())).thenReturn(productDocRef);
    when(() => usersCollection.doc(any())).thenReturn(userDocRef);

    repo = ItemDetailsRepoImpl(mockFirestore);
  });

  group('ItemDetailsRepoImpl Tests', () {
    test('returns ItemDetailsModel when product and owner exist', () async {
      when(
        () => productDocRef.get(),
      ).thenAnswer((_) async => productDocSnapshot);
      when(() => productDocSnapshot.exists).thenReturn(true);
      when(() => productDocSnapshot.id).thenReturn('prod_1');
      when(() => productDocSnapshot.data()).thenReturn({
        'title': 'Sony Camera',
        'dailyPrice': 50.0,
        'userId': 'owner_123',
      });

      when(() => userDocRef.get()).thenAnswer((_) async => userDocSnapshot);
      when(() => userDocSnapshot.exists).thenReturn(true);
      when(() => userDocSnapshot.data()).thenReturn({
        'firstName': 'Sarah',
        'lastName': 'Connor',
        'verificationStatus': 'verified',
      });

      final result = await repo.getItemDetails('prod_1');

      expect(result.isRight(), true);
      result.fold((_) => fail('Should succeed'), (details) {
        expect(details.id, 'prod_1');
        expect(details.name, 'Sony Camera');
        expect(details.ownerId, 'owner_123');
        expect(details.ownerName, 'Sarah Connor');
        expect(details.ownerVerificationStatus, 'verified');
      });
    });

    test(
      'returns ServerFailure when product document does not exist',
      () async {
        when(
          () => productDocRef.get(),
        ).thenAnswer((_) async => productDocSnapshot);
        when(() => productDocSnapshot.exists).thenReturn(false);

        final result = await repo.getItemDetails('prod_missing');

        expect(result.isLeft(), true);
        result.fold(
          (failure) => expect(failure.message, 'Product not found.'),
          (_) => fail('Should fail'),
        );
      },
    );
  });
}

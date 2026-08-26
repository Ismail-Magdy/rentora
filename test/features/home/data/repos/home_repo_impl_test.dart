import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/home/data/repos/home_repo_impl.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockCollectionReference usersCollection;
  late MockCollectionReference productsCollection;
  late MockDocumentReference userDocRef;
  late MockDocumentSnapshot userDocSnapshot;
  late HomeRepoImpl homeRepo;

  setUp(() {
    mockFirestore = MockFirestore();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    usersCollection = MockCollectionReference();
    productsCollection = MockCollectionReference();
    userDocRef = MockDocumentReference();
    userDocSnapshot = MockDocumentSnapshot();

    when(() => mockFirestore.collection('users')).thenReturn(usersCollection);
    when(
      () => mockFirestore.collection('products'),
    ).thenReturn(productsCollection);
    when(() => usersCollection.doc(any())).thenReturn(userDocRef);

    homeRepo = HomeRepoImpl(mockFirestore, mockAuth);
  });

  group('HomeRepoImpl Tests', () {
    test(
      'getUserCategories returns default categories when user is not logged in',
      () async {
        when(() => mockAuth.currentUser).thenReturn(null);

        final result = await homeRepo.getUserCategories();

        expect(result.isRight(), true);
        result.fold((_) => fail('Should succeed'), (categories) {
          expect(categories, contains('Cameras'));
          expect(categories, contains('Gaming'));
        });
      },
    );

    test(
      'getUserCategories returns user interests when present in document',
      () async {
        when(() => mockAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('u123');
        when(() => userDocRef.get()).thenAnswer((_) async => userDocSnapshot);
        when(() => userDocSnapshot.exists).thenReturn(true);
        when(() => userDocSnapshot.data()).thenReturn({
          'interests': ['Drones', 'VR'],
        });

        final result = await homeRepo.getUserCategories();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should succeed'),
          (categories) => expect(categories, ['Drones', 'VR']),
        );
      },
    );

    test(
      'getProducts returns product list filtering out current user if requested',
      () async {
        final mockQuery = MockQuery();
        final mockQuerySnapshot = MockQuerySnapshot();
        final doc1 = MockQueryDocumentSnapshot();
        final doc2 = MockQueryDocumentSnapshot();

        when(() => mockAuth.currentUser).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn('my_uid');

        when(() => productsCollection.limit(50)).thenReturn(mockQuery);
        when(() => mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);

        when(() => doc1.id).thenReturn('p1');
        when(() => doc1.data()).thenReturn({
          'title': 'Item 1',
          'category': 'Cameras',
          'dailyPrice': 30.0,
          'userId': 'other_uid',
        });

        when(() => doc2.id).thenReturn('p2');
        when(() => doc2.data()).thenReturn({
          'title': 'Item 2',
          'category': 'Cameras',
          'dailyPrice': 40.0,
          'userId': 'my_uid',
        });

        when(() => mockQuerySnapshot.docs).thenReturn([doc1, doc2]);

        final result = await homeRepo.getProducts(excludeCurrentUser: true);

        expect(result.isRight(), true);
        result.fold((_) => fail('Should succeed'), (products) {
          expect(products.length, 1);
          expect(products.first.id, 'p1');
        });
      },
    );

    test('getUserLocation returns location GeoPoint from user doc', () async {
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('u123');
      when(() => userDocRef.get()).thenAnswer((_) async => userDocSnapshot);
      when(() => userDocSnapshot.exists).thenReturn(true);
      when(
        () => userDocSnapshot.data(),
      ).thenReturn({'location': const GeoPoint(30.05, 31.25)});

      final result = await homeRepo.getUserLocation();

      expect(result.isRight(), true);
      result.fold((_) => fail('Should succeed'), (geo) {
        expect(geo, isNotNull);
        expect(geo!.latitude, 30.05);
      });
    });
  });
}

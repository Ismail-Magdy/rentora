import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:rentora/features/home/data/models/product_model.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockCollectionReference usersCollection;
  late MockDocumentReference userDoc;
  late MockCollectionReference favoritesCollection;
  late MockDocumentReference favoriteDoc;
  late FavoritesRepoImpl repo;

  final tProduct = ProductModel(
    id: 'prod_1',
    name: 'Camera',
    category: 'Cameras',
    price: 45.0,
    rating: 4.8,
    distance: 2.0,
    locationName: 'Cairo',
    imageUrl: 'https://example.com/cam.jpg',
    ownerId: 'owner_1',
  );

  setUp(() {
    mockFirestore = MockFirestore();
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    usersCollection = MockCollectionReference();
    userDoc = MockDocumentReference();
    favoritesCollection = MockCollectionReference();
    favoriteDoc = MockDocumentReference();

    when(() => mockFirestore.collection('users')).thenReturn(usersCollection);
    when(() => usersCollection.doc(any())).thenReturn(userDoc);
    when(() => userDoc.collection('favorites')).thenReturn(favoritesCollection);
    when(() => favoritesCollection.doc(any())).thenReturn(favoriteDoc);

    repo = FavoritesRepoImpl(mockFirestore, mockAuth);
  });

  group('FavoritesRepoImpl Tests', () {
    test(
      'getFavorites returns empty list when user is not logged in',
      () async {
        when(() => mockAuth.currentUser).thenReturn(null);

        final result = await repo.getFavorites();

        expect(result, isEmpty);
      },
    );

    test('getFavorites returns product list when user is logged in', () async {
      final mockSnapshot = MockQuerySnapshot();
      final mockDocSnapshot = MockQueryDocumentSnapshot();

      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user_123');
      when(() => mockDocSnapshot.id).thenReturn('prod_1');
      when(() => mockDocSnapshot.data()).thenReturn({
        'title': 'Camera',
        'category': 'Cameras',
        'dailyPrice': 45.0,
        'rating': 4.8,
        'location': 'Cairo',
        'imageUrls': ['https://example.com/cam.jpg'],
        'userId': 'owner_1',
      });
      when(() => mockSnapshot.docs).thenReturn([mockDocSnapshot]);
      when(
        () => favoritesCollection.get(),
      ).thenAnswer((_) async => mockSnapshot);

      final result = await repo.getFavorites();

      expect(result.length, 1);
      expect(result.first.id, 'prod_1');
      expect(result.first.name, 'Camera');
    });

    test('addToFavorites sets data in firestore', () async {
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user_123');
      when(() => favoriteDoc.set(any())).thenAnswer((_) async {});

      await repo.addToFavorites(tProduct);

      verify(() => favoriteDoc.set(any())).called(1);
    });

    test('removeFromFavorites deletes doc from firestore', () async {
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('user_123');
      when(() => favoriteDoc.delete()).thenAnswer((_) async {});

      await repo.removeFromFavorites('prod_1');

      verify(() => favoriteDoc.delete()).called(1);
    });
  });
}

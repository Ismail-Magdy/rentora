import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/features/auth/data/repos/auth_repo.dart';

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockUsersFirestoreService extends Mock implements UsersFirestoreService {}

void main() {
  late MockFirebaseAuthService authService;
  late MockUsersFirestoreService usersService;
  late AuthRepo repo;

  setUp(() {
    authService = MockFirebaseAuthService();
    usersService = MockUsersFirestoreService();
    repo = AuthRepo(authService: authService, usersService: usersService);
  });

  test('signOut calls authService.signOut', () async {
    when(() => authService.signOut()).thenAnswer((_) async {});
    await repo.signOut();
    verify(() => authService.signOut()).called(1);
  });
}

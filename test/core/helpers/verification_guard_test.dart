import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/helpers/verification_guard.dart';
import 'package:rentora/core/network/firebase/firebase_auth_service.dart';
import 'package:rentora/core/network/firebase/users_firestore_service.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockUsersFirestoreService extends Mock implements UsersFirestoreService {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirebaseAuthService mockAuth;
  late MockUsersFirestoreService mockFirestore;
  late MockDocumentSnapshot mockDoc;

  setUp(() {
    mockAuth = MockFirebaseAuthService();
    mockFirestore = MockUsersFirestoreService();
    mockDoc = MockDocumentSnapshot();

    GetIt.I.reset();
    GetIt.I.registerSingleton<FirebaseAuthService>(mockAuth);
    GetIt.I.registerSingleton<UsersFirestoreService>(mockFirestore);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  Widget buildTestApp(WidgetBuilder builder) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, _) => MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: Builder(builder: builder)),
      ),
    );
  }

  testWidgets('executes onVerified callback when status is verified', (
    tester,
  ) async {
    when(() => mockAuth.getCurrentUserId()).thenReturn('user_123');
    when(
      () => mockFirestore.getUserProfile(userId: 'user_123'),
    ).thenAnswer((_) async => mockDoc);
    when(() => mockDoc.data()).thenReturn({'verificationStatus': 'verified'});

    bool verifiedCalled = false;

    await tester.pumpWidget(
      buildTestApp((context) {
        return ElevatedButton(
          onPressed: () {
            VerificationGuard.check(
              context,
              onVerified: () => verifiedCalled = true,
            );
          },
          child: const Text('Check'),
        );
      }),
    );

    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();

    expect(verifiedCalled, isTrue);
  });

  testWidgets('shows pending dialog when status is pending', (tester) async {
    when(() => mockAuth.getCurrentUserId()).thenReturn('user_123');
    when(
      () => mockFirestore.getUserProfile(userId: 'user_123'),
    ).thenAnswer((_) async => mockDoc);
    when(() => mockDoc.data()).thenReturn({'verificationStatus': 'pending'});

    bool verifiedCalled = false;

    await tester.pumpWidget(
      buildTestApp((context) {
        return ElevatedButton(
          onPressed: () {
            VerificationGuard.check(
              context,
              onVerified: () => verifiedCalled = true,
            );
          },
          child: const Text('Check'),
        );
      }),
    );

    await tester.tap(find.text('Check'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(verifiedCalled, isFalse);
    expect(find.byIcon(Icons.hourglass_top_rounded), findsOneWidget);
  });
}

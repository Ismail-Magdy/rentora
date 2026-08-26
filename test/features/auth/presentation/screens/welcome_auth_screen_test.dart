import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/auth/manager/auth_cubit.dart';
import 'package:rentora/features/auth/manager/auth_state.dart';
import 'package:rentora/features/auth/presentation/screens/welcome_auth_screen.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

Widget createWelcomeAuthTestWidget(AuthCubit cubit) {
  return ScreenUtilInit(
    designSize: const Size(428, 926),
    builder: (context, _) => MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<AuthCubit>.value(
        value: cubit,
        child: const WelcomeAuthScreen(),
      ),
    ),
  );
}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
  });

  group('WelcomeAuthScreen Widget Tests', () {
    testWidgets('renders login, registration, and Google sign in buttons', (
      tester,
    ) async {
      when(() => mockAuthCubit.state).thenReturn(AuthInitial());

      await tester.pumpWidget(createWelcomeAuthTestWidget(mockAuthCubit));
      await tester.pumpAndSettle();

      expect(find.text('Log In'), findsOneWidget);
      expect(find.text('Registration'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('triggers signInWithGoogle when google button is pressed', (
      tester,
    ) async {
      when(() => mockAuthCubit.state).thenReturn(AuthInitial());
      when(() => mockAuthCubit.signInWithGoogle()).thenAnswer((_) async {});

      await tester.pumpWidget(createWelcomeAuthTestWidget(mockAuthCubit));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue with Google'));
      await tester.pumpAndSettle();

      verify(() => mockAuthCubit.signInWithGoogle()).called(1);
    });

    testWidgets('shows loading indicator when AuthLoading state is emitted', (
      tester,
    ) async {
      when(() => mockAuthCubit.state).thenReturn(AuthLoading());

      await tester.pumpWidget(createWelcomeAuthTestWidget(mockAuthCubit));
      await tester.pump();

      expect(find.text('Continue with Google'), findsNothing);
    });
  });
}

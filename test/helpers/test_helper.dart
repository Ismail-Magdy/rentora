import 'dart:async';
import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/core/themes/app_theme.dart';
import 'package:rentora/features/favorites/manager/favorites_cubit.dart';
import 'package:rentora/features/favorites/manager/favorites_state.dart';
import 'package:rentora/features/home/data/models/product_model.dart';
import 'package:rentora/features/search/data/models/search_filter_model.dart';
import 'package:rentora/features/search/data/repos/search_repo.dart';
import 'package:rentora/features/search/manager/search_cubit.dart';
import 'package:rentora/features/search/manager/search_state.dart';
import 'package:rentora/l10n/generated/app_localizations.dart';

const List<int> kTransparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];

class MockHttpClient extends Mock implements HttpClient {}

class MockHttpClientRequest extends Mock implements HttpClientRequest {}

class MockHttpClientResponse extends Mock implements HttpClientResponse {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

class MockHttpOverrides extends HttpOverrides {
  MockHttpOverrides() {
    try {
      registerFallbackValue(Uri());
    } catch (_) {}
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    try {
      registerFallbackValue(Uri());
    } catch (_) {}
    final client = MockHttpClient();
    final request = MockHttpClientRequest();
    final response = MockHttpClientResponse();
    final headers = MockHttpHeaders();

    when(() => client.getUrl(any())).thenAnswer((_) async => request);
    when(() => client.openUrl(any(), any())).thenAnswer((_) async => request);
    when(() => request.headers).thenReturn(headers);
    when(() => request.close()).thenAnswer((_) async => response);
    when(() => response.statusCode).thenReturn(200);
    when(() => response.contentLength).thenReturn(kTransparentImage.length);
    when(
      () => response.compressionState,
    ).thenReturn(HttpClientResponseCompressionState.notCompressed);
    when(
      () => response.listen(
        any(),
        onError: any(named: 'onError'),
        onDone: any(named: 'onDone'),
        cancelOnError: any(named: 'cancelOnError'),
      ),
    ).thenAnswer((invocation) {
      final void Function(List<int>) onData = invocation.positionalArguments[0];
      final void Function()? onDone = invocation.namedArguments[#onDone];
      final void Function(Object, [StackTrace?])? onError =
          invocation.namedArguments[#onError];
      final bool? cancelOnError = invocation.namedArguments[#cancelOnError];

      return Stream<List<int>>.fromIterable([kTransparentImage]).listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
    });

    return client;
  }
}

void initTestEnvironment() {
  try {
    registerFallbackValue(Uri());
  } catch (_) {}
  try {
    registerFallbackValue(const SearchFilterModel());
  } catch (_) {}
  HttpOverrides.global = MockHttpOverrides();
}

class MockSearchRepo extends Mock implements SearchRepo {}

class MockSearchCubit extends MockCubit<SearchState> implements SearchCubit {}

class MockFavoritesCubit extends MockCubit<FavoritesState>
    implements FavoritesCubit {}

class FakeSearchFilterModel extends Fake implements SearchFilterModel {}

ProductModel createDummyProduct({
  String id = 'prod_1',
  String name = 'Sony Alpha A7 IV',
  String category = 'Cameras',
  double price = 45.0,
  double rating = 4.8,
  double distance = 2.5,
  String locationName = 'Downtown, Cairo',
  String imageUrl = 'https://example.com/image.jpg',
  String ownerId = 'user_123',
  bool isFavorite = false,
}) {
  return ProductModel(
    id: id,
    name: name,
    category: category,
    price: price,
    rating: rating,
    distance: distance,
    locationName: locationName,
    imageUrl: imageUrl,
    ownerId: ownerId,
    isFavorite: isFavorite,
  );
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    SearchCubit? searchCubit,
    FavoritesCubit? favoritesCubit,
    NavigatorObserver? navigatorObserver,
    RouteFactory? onGenerateRoute,
    ThemeMode themeMode = ThemeMode.light,
  }) async {
    final mockFavorites = favoritesCubit ?? MockFavoritesCubit();
    if (favoritesCubit == null) {
      when(() => mockFavorites.state).thenReturn(FavoritesInitial());
      when(() => mockFavorites.isFavorite(any())).thenReturn(false);
      when(() => mockFavorites.favorites).thenReturn([]);
    }

    await pumpWidget(
      MultiBlocProvider(
        providers: [
          if (searchCubit != null)
            BlocProvider<SearchCubit>.value(value: searchCubit),
          BlocProvider<FavoritesCubit>.value(value: mockFavorites),
        ],
        child: ScreenUtilInit(
          designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: const Locale('en'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              navigatorObservers: [
                if (navigatorObserver != null) navigatorObserver,
              ],
              onGenerateRoute: onGenerateRoute,
              home: Material(child: widget),
            );
          },
        ),
      ),
    );
    await pump();
  }
}

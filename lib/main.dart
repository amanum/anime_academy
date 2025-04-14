import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/app/models/key_value_store.dart';
import 'package:anime_academy/bloc/app/app_bloc.dart';
import 'package:anime_academy/bloc/auth/auth_bloc.dart';
import 'package:anime_academy/bloc/comics/comics_bloc.dart';
import 'package:anime_academy/bloc/test/test_bloc.dart';
import 'package:anime_academy/data/auth_store_result.dart';
import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/domain/repository/auth_repository.dart';
import 'package:anime_academy/domain/repository/auth_store_repository.dart';
import 'package:anime_academy/domain/repository/comics_repository.dart';
import 'package:anime_academy/domain/repository/test_repository.dart';
import 'package:anime_academy/domain/repository/universe_repository.dart';
import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/router/app_router.dart';
import 'package:anime_academy/services/app_state_storage.dart';
import 'package:anime_academy/ui/screen/auth/login_screen.dart';
import 'package:anime_academy/ui/screen/universe_select/universe_select_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final _appRouter = AppRouter();

  // Инициализация хранилища
  final keyValueStore = KeyValueStore();
  await keyValueStore.initialize();

  // Инициализация сервисов
  final authStoreRepository = AuthStoreRepository(store: keyValueStore);
  final appStateStorage = AppStateStorage(store: keyValueStore);

  // Инициализация HTTP клиента
  final httpClient = HttpClient(
    baseUrl: AniConfig.baseUrlApi,
    onReadToken: () async {
      final tokenResult = await authStoreRepository.getToken();
      switch (tokenResult) {
        case AuthStoreResultSuccess<TokenData>():
          return tokenResult.data;
        case AuthStoreResultFailure():
          return null;
      }
    },
    onSaveToken: authStoreRepository.setToken,
  );

  // Инициализация репозиториев
  final authRepository = AuthRepository(
    httpClient: httpClient,
    authStoreRepository: authStoreRepository,
    appStateStorage: appStateStorage,
  );
  final testRepository = TestRepository(http: httpClient);
  final comicsRepository = ComicsRepository(http: httpClient);

  final universeRepository = UniverseRepository(http: httpClient);

  // Создаем блоки без взаимных зависимостей
  final appBloc = AppBloc(
    storage: appStateStorage,
    authRepository: authRepository,
  )..add(const AppLoadEvent());

  final authBloc = AuthBloc(
    authRepository: authRepository,
  )..add(const AuthCheckRequested());

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: universeRepository),
        RepositoryProvider.value(value: testRepository),
        RepositoryProvider.value(value: comicsRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
          BlocProvider<AppBloc>.value(value: appBloc),
        ],
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) =>
              previous.languageCode != current.languageCode,
          builder: (context, appState) {
            return MaterialApp.router(
              routerConfig: _appRouter.config(),
              title: 'Anime Academy',
              theme: ThemeData(
                primarySwatch: Colors.indigo,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AniColors.white,
                    backgroundColor: AniColors.accent,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.supportedLocales,
              locale: Locale(appState.languageCode),
              // home: BlocBuilder<AuthBloc, AuthState>(
              //   builder: (context, state) {
              //     // Проверяем состояние авторизации
              //     if (state is AuthInitial || state is AuthLoading) {
              //       return const Scaffold(
              //         body: Center(
              //           child: CircularProgressIndicator(),
              //         ),
              //       );
              //     } else if (state is AuthSuccess) {
              //       return const UniverseSelectScreen();
              //     } else {
              //       return const LoginScreen();
              //     }
              //   },
              // ),
            );
          },
        ),
      ),
    ),
  );
}

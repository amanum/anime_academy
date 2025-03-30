import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/app/models/key_value_store.dart';
import 'package:anime_academy/bloc/auth/auth_bloc.dart';
import 'package:anime_academy/data/auth_store_result.dart';
import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/domain/repository/auth_repository.dart';
import 'package:anime_academy/domain/repository/auth_store_repository.dart';
import 'package:anime_academy/domain/repository/universe_repository.dart';
import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/ui/screen/auth/login_screen.dart';
import 'package:anime_academy/ui/screen/universe_select/universe_select_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация зависимостей
  // await Dependencies.init();

  final keyValueStore = KeyValueStore();
  await keyValueStore.initialize();

  final authStoreRepository = AuthStoreRepository(store: keyValueStore);

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

  final authRepository = AuthRepository(
      httpClient: httpClient, authStoreRepository: authStoreRepository);
  final universeRepository = UniverseRepository(http: httpClient);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: universeRepository),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: authRepository,
        )..add(const AuthCheckRequested()),
        child: MaterialApp(
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

          /// TODO(umurzakov): refactor after dependencies initialization ready
          locale: S.supportedLocales.last,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // Проверяем состояние авторизации
              if (state is AuthInitial || state is AuthLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is AuthSuccess) {
                return const UniverseSelectScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
        ),
      ),
    ),
  );
}

import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/app/models/key_value_store.dart';
import 'package:anime_academy/data/auth_store_result.dart';
import 'package:anime_academy/data/http_client.dart';
import 'package:anime_academy/data/token_data.dart';
import 'package:anime_academy/domain/repository/auth_store_repository.dart';
import 'package:anime_academy/domain/repository/universe_repository.dart';
import 'package:anime_academy/localization/generated/ani_localization.dart';
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
    baseUrl: AniConfig.baseUrl,
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

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UniverseRepository>(
          create: (_) => UniverseRepository(http: httpClient),
        ),
      ],
      child: MaterialApp(
        title: 'Anime Academy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Montserrat',
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
        home: const UniverseSelectScreen(),
      ),
    ),
  );
}

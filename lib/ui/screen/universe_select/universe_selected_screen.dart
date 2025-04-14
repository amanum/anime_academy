import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/bloc/app/app_bloc.dart';
import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/ui/screen/home/home_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniverseSelectedScreen extends StatelessWidget {
  const UniverseSelectedScreen(this.universe, {super.key});

  final Universe universe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.loose,
              children: [
                if (universe.descImage != null)Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Image.network(
                    '${AniConfig.baseUrl}${universe.descImage!.url}',
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Container(
                  height: 16,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: AniColors.white,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: SafeArea(
                    bottom: false,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                            color: AniColors.white, shape: BoxShape.circle),
                        child: Icon(Icons.arrow_back_rounded),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(32, 8, 32, 20),
            color: AniColors.white,
            child: Column(
              children: [
                Text(
                  universe.titleRu,
                  style: AniFonts.f_32_700,
                ),
                const SizedBox(height: 8),
                Text(
                  universe.descriptionRu ?? '',
                  style: AniFonts.f_20_500,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AppBloc, AppState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            // Сохраняем выбранную вселенную в AppBloc
                            context.read<AppBloc>().add(
                              AppSelectUniverseEvent(universe: universe),
                            );
                            
                            // Обновляем данные пользователя перед переходом на главный экран
                            context.read<AppBloc>().add(
                              const AppUpdateUserEvent(),
                            );
                            
                            // Переходим на главный экран
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                              (route) => false,
                            );
                          },
                          child: Text(S.of(context).start),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

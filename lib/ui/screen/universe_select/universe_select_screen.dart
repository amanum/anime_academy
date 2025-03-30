import 'package:anime_academy/bloc/universe/universe_bloc.dart';
import 'package:anime_academy/domain/repository/universe_repository.dart';
import 'package:anime_academy/ui/screen/universe_select/universe_selected_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:anime_academy/ui/widget/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UniverseSelectScreen extends StatelessWidget {
  const UniverseSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<UniverseRepository>();
    return Scaffold(
      backgroundColor: AniColors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocProvider(
              create: (context) => UniverseBloc(
                repository: repo,
              )..add(const UniverseEventLoad()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Привет Absamat 👋',
                    style: AniFonts.f_16_400,
                  ),
                  Text('Удачного дня!', style: AniFonts.f_28_700),
                  SizedBox(height: 40),
                  Text('Выбери свое приключение!', style: AniFonts.f_20_700),
                  SizedBox(height: 12),
                  BlocBuilder<UniverseBloc, UniverseState>(
                    builder: (context, state) {
                      if (state is UniverseStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UniverseStateLoaded) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: state.universes.length,
                          itemBuilder: (context, index) {
                            final universe = state.universes[index];
                            return GestureDetector(
                              onTap: () {
                                context.read<UniverseBloc>().add(
                                      UniverseEventSelect(
                                          universeId: universe.id),
                                    );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        UniverseSelectedScreen(universe),
                                  ),
                                );
                              },
                              child: ImageCard(
                                image: universe.image,
                                title: universe.titleRu,
                                text: universe.descriptionRu,
                              ),
                            );
                          },
                        );
                      } else {
                        // Состояние ошибки или другое непредвиденное состояние
                        return const Center(
                          child:
                              Text('Произошла ошибка при загрузке вселенных'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

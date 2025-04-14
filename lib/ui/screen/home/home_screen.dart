import 'package:anime_academy/bloc/app/app_bloc.dart';
import 'package:anime_academy/bloc/auth/auth_bloc.dart';
import 'package:anime_academy/bloc/comics/comics_bloc.dart';
import 'package:anime_academy/bloc/test/test_bloc.dart';
import 'package:anime_academy/core/entity/ani_test.dart';
import 'package:anime_academy/core/entity/card_item.dart';
import 'package:anime_academy/core/entity/comics.dart';
import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/domain/repository/comics_repository.dart';
import 'package:anime_academy/domain/repository/test_repository.dart';
import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/ui/screen/comics/comics_screen.dart';
import 'package:anime_academy/ui/screen/full_content_list/full_content_list_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:anime_academy/ui/widget/image_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testBloc = TestBloc(
      repository: context.read<TestRepository>(),
    )..add(const TestEventLoad());

    final comicsBloc = ComicsBloc(
      repository: context.read<ComicsRepository>(),
    )..add(const ComicsEventLoad());
    return MultiBlocProvider(
      providers: [
        BlocProvider<TestBloc>.value(value: testBloc),
        BlocProvider<ComicsBloc>.value(value: comicsBloc),
      ],
      child: Scaffold(
        backgroundColor: AniColors.white,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 20,
              children: [
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${S.of(context).hello} ${state.user?.username} 👋',
                                  style: AniFonts.f_16_400),
                              Text(S.of(context).haveANiceDay,
                                  style: AniFonts.f_28_700),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthLogoutRequested());
                          },
                          child: Container(
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: AniColors.accent,
                            ),
                            child: SizedBox(
                              // height: 45,
                              // width: 45,
                              child: Image.network(
                                'https://w7.pngwing.com/pngs/589/151/png-transparent-pixel-art-drawing-naruto-thumbnail.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<TestBloc, TestState>(
                  builder: (context, state) {
                    switch (state) {
                      case TestStateLoading():
                        return const CircularProgressIndicator();
                      case TestStateLoaded(tests: List<AniTest> tests):
                        return _Section(
                          title: S.of(context).knowledgeBattle,
                          items: tests,
                          onAllTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FullContentListScreen()));
                          },
                          onTap: (_) {},
                        );
                      case TestStateError():
                        return const Text('Error');
                    }
                  },
                ),
                BlocBuilder<ComicsBloc, ComicsState>(
                  builder: (context, state) {
                    switch (state) {
                      case ComicsStateLoading():
                        return const CircularProgressIndicator();
                      case ComicsStateLoaded(comics: List<Comics> comics):
                        return _Section(
                          title: S.of(context).comics,
                          items: comics,
                          onAllTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FullContentListScreen()));
                          },
                          onTap: (comics) {
                            if (comics is Comics && comics.pdfList.isNotEmpty) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ComicsScreen(
                                      url: comics.pdfList.first.url)));
                            }
                          },
                        );
                      case ComicsStateError():
                        return const Text('Error');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.items,
    required this.onAllTap,
    required this.onTap,
  });

  final String title;
  final List<CardItem> items;
  final VoidCallback onAllTap;
  final Function(CardItem) onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AniFonts.f_20_500),
            TextButton(
              onPressed: onAllTap,
              child: Text(
                S.of(context).all,
                style: AniFonts.f_14_500.copyWith(color: AniColors.accent),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 180,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTap(items[index]),
                child: SizedBox(
                  width: 160,
                  child: ImageCard(
                    imageUrl: items[index].imageUrl,
                    title: items[index].title,
                    text: items[index].text,
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        ),
      ],
    );
  }
}

import 'package:anime_academy/core/entity/card_item.dart';
import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/ui/screen/full_content_list/full_content_list_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:anime_academy/ui/widget/image_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AniColors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 20,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${S.of(context).hello} Absamat 👋',
                            style: AniFonts.f_16_400),
                        Text(S.of(context).haveANiceDay,
                            style: AniFonts.f_28_700),
                      ],
                    ),
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AniColors.accent,
                    ),
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: Image.network(
                          'https://w7.pngwing.com/pngs/589/151/png-transparent-pixel-art-drawing-naruto-thumbnail.png'),
                    ),
                  ),
                ],
              ),
              _Section(
                title: S.of(context).knowledgeBattle,
                items: [
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                ],
                onAllTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FullContentListScreen()));
                },
              ),
              _Section(
                title: S.of(context).comics,
                items: [
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                  Universe(
                    id: 1,
                    title: 'Математика',
                    description: 'Экзамен на звание чунина',
                    imageUrl:
                        'https://static1.srcdn.com/wordpress/wp-content/uploads/2024/05/10-ways-naruto-changed-anime-forever.jpg',
                  ),
                ],
                onAllTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => FullContentListScreen()));
                },
              ),
            ],
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
  });

  final String title;
  final List<Universe> items;
  final VoidCallback onAllTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox.shrink();
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
              return SizedBox(
                width: 160,
                child: ImageCard(
                  imageUrl: items[index].imageUrl,
                  title: items[index].title,
                  text: items[index].description,
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(width: 12),
          ),
        ),
      ],
    );
  }
}

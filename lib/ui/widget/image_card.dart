import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_const.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.imageUrl,
    required this.title,
    this.text,
    super.key,
  });

  final String imageUrl;
  final String title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AniConst.radiusS),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: AniColors.white,
          borderRadius: BorderRadius.circular(AniConst.radiusS),
          border: Border.all(color: AniColors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                width: double.infinity,
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AniFonts.f_16_700,
                  ),
                  if (text != null)
                    Text(
                      text!,
                      style: AniFonts.f_12_500,
                      maxLines: 2,
                    ),
                ],
              ),
            ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Column(
        //     children: [
        //       Text(
        //         title,
        //         style: AniFonts.f_16_700,
        //       ),
        //       if (text != null) Text(text!, style: AniFonts.f_12_500),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

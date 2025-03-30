import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/core/entity/ani_image.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_const.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.image,
    required this.title,
    this.text,
    super.key,
  });

  final AniImage? image;
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
              child: image != null ? Image.network(
                width: double.infinity,
                '${AniConfig.baseUrl}${image!.url}',
                fit: BoxFit.cover,
              ) : const SizedBox.shrink(),
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

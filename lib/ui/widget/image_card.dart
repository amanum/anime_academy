import 'package:anime_academy/ani_config.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_const.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.imageUrl,
    required this.title,
    this.text,
    this.overlayColorString,
    super.key,
  });

  final String? imageUrl;
  final String title;
  final String? text;
  final String? overlayColorString;

  Color get _overlayColor {
    if (overlayColorString != null && overlayColorString!.isNotEmpty) {
      String hexColor = overlayColorString!.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF$hexColor";
      }
      final color = Color(int.parse(hexColor, radix: 16));
      return color;
    }
    return Colors.transparent;
  }

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
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl != null
                ? Image.network(
                    width: double.infinity,
                    '${AniConfig.baseUrl}$imageUrl',
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    _overlayColor,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                title,
                style: AniFonts.f_16_400.copyWith(color: AniColors.white),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //   child: Column(
            //     spacing: 8,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         title,
            //         style: AniFonts.f_16_700,
            //       ),
            //       if (text != null)
            //         Text(
            //           text!,
            //           style: AniFonts.f_12_500,
            //           maxLines: 2,
            //         ),
            //     ],
            //   ),
            // ),
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

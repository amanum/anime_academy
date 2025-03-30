import 'package:anime_academy/localization/generated/ani_localization.dart';
import 'package:anime_academy/ui/screen/home/home_screen.dart';
import 'package:anime_academy/ui/style/ani_colors.dart';
import 'package:anime_academy/ui/style/ani_fonts.dart';
import 'package:flutter/material.dart';

class UniverseSelectedScreen extends StatelessWidget {
  const UniverseSelectedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  'https://strapiassets.s3.us-east-2.wasabisys.com/4_H3_Recreate_6d66ab7b1b.webp',
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
                Container(
                  height: 16,
                  decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
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
            padding: EdgeInsets.fromLTRB(32, 8, 32, 20),
            color: AniColors.white,
            child: Column(
              children: [
                Text(
                  'Наруто',
                  style: AniFonts.f_32_700,
                ),
                SizedBox(height: 8),
                Text(
                  'Присоединяйся к Наруто и его друзьям в их приключениях и учись новому!',
                  style: AniFonts.f_20_500,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
                      },
                      child: Text(S.of(context).start),
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

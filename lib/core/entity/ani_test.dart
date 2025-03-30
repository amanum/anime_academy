import 'package:anime_academy/core/entity/ani_image.dart';

class AniTest {
  final int id;
  final String titleRu;
  final String descriptionRu;
  final AniImage image;
  final bool top;

  const AniTest({
    required this.id,
    required this.titleRu,
    required this.descriptionRu,
    required this.image,
    required this.top,
  });

  factory AniTest.fromJson(Map<String, dynamic> json) {
    return AniTest(
      id: json['id'] as int,
      titleRu: json['attributes']['title_ru'] as String,
      descriptionRu: json['attributes']['description_ru'] as String,
      image: AniImage.fromJson(json['attributes']['img'] as Map<String, dynamic>),
      top: json['attributes']['top'] as bool,
    );
  }
}
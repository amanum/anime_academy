import 'package:anime_academy/core/entity/ani_image.dart';
import 'package:anime_academy/core/entity/card_item.dart';

class AniTest implements CardItem{
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

  @override
  String get imageUrl => image.url;
  @override
  String get title => titleRu;
  @override
  String get text => descriptionRu;

  factory AniTest.fromJson(Map<String, dynamic> json) {
    return AniTest(
      id: json['id'] as int,
      titleRu: json['title_ru'] as String,
      descriptionRu: json['description_ru'] as String,
      image: AniImage.fromJson(json['img'] as Map<String, dynamic>),
      top: json['top'] as bool,
    );
  }
}
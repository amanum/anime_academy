import 'package:anime_academy/core/entity/ani_image.dart';
import 'package:anime_academy/core/entity/ani_pdf.dart';
import 'package:anime_academy/core/entity/card_item.dart';

class Comics implements CardItem {
  final int id;
  final String titleRu;
  final String descriptionRu;
  final AniImage image;
  final bool top;
  final AniPdf pdf;

  const Comics({
    required this.id,
    required this.titleRu,
    required this.descriptionRu,
    required this.image,
    required this.top,
    required this.pdf,
  });

  @override
  String get imageUrl => image.url;
  @override
  String get title => titleRu;
  @override
  String get text => descriptionRu;

  factory Comics.fromJson(Map<String, dynamic> json) {
    return Comics(
      id: json['id'] as int,
      titleRu: json['title_ru'] as String,
      descriptionRu: json['description_ru'] as String,
      image: AniImage.fromJson(json['image'] as Map<String, dynamic>),
      top: json['top'] as bool,
      pdf: AniPdf.fromJson(json['pdf_ru'] as Map<String, dynamic>),
    );
  }
}

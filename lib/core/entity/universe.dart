import 'dart:convert';

import 'package:anime_academy/core/entity/ani_image.dart';
import 'package:anime_academy/core/entity/card_item.dart';

/// Модель вселенной аниме
class Universe implements CardItem {
  /// Уникальный идентификатор вселенной
  final int id;
  
  /// Название вселенной
  final String titleRu;
  
  /// Описание вселенной
  final String? descriptionRu;
  
  /// URL изображения вселенной
  final AniImage? image;
  final AniImage? descImage;

  final String? colorString;

  @override
  String get imageUrl => image?.url ?? '';
  @override
  String get title => titleRu;
  @override
  String get text => descriptionRu ?? '';

  Universe({
    required this.id, 
    required this.titleRu,
    required this.image,
    required this.colorString,
    this.descImage,
    this.descriptionRu,
  });
  
  /// Создает экземпляр вселенной из JSON
  factory Universe.fromJson(Map<String, dynamic> json) {
    return Universe(
      id: json['id'] as int,
      titleRu: json['title_ru'] as String,
      descriptionRu: json['description_ru'] as String?,
      image: AniImage.fromJson(json['img'] as Map<String, dynamic>),
      descImage: AniImage.fromJson(json['desc_img'] as Map<String, dynamic>),
      colorString: json['color'],
    );
  }
  
  /// Конвертирует вселенную в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_ru': titleRu,
      'description_ru': descriptionRu,
      'img': jsonEncode(image),
      'desc_img': jsonEncode(descImage),
      'color': colorString,
    };
  }
}

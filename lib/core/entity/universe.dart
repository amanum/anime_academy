import 'dart:convert';

import 'package:anime_academy/core/entity/ani_image.dart';

/// Модель вселенной аниме
class Universe {
  /// Уникальный идентификатор вселенной
  final int id;
  
  /// Название вселенной
  final String titleRu;
  
  /// Описание вселенной
  final String? descriptionRu;
  
  /// URL изображения вселенной
  final AniImage? image;
  final AniImage? descImage;

  Universe({
    required this.id, 
    required this.titleRu,
    required this.image,
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
    };
  }
}

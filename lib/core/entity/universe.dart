/// Модель вселенной аниме
class Universe {
  /// Уникальный идентификатор вселенной
  final int id;
  
  /// Название вселенной
  final String title;
  
  /// Описание вселенной
  final String? description;
  
  /// URL изображения вселенной
  final String imageUrl;
  
  Universe({
    required this.id, 
    required this.title,
    this.description, 
    required this.imageUrl,
  });
  
  /// Создает экземпляр вселенной из JSON
  factory Universe.fromJson(Map<String, dynamic> json) {
    return Universe(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String,
    );
  }
  
  /// Конвертирует вселенную в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
    };
  }
}

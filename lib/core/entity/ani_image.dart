class AniImage {
  final int id;
  final double width;
  final double height;
  final String url;

  const AniImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });

  factory AniImage.fromJson(Map<String, dynamic> json) {
    return AniImage(
      id: json['id'] as int,
      width: (json['width'] as int).toDouble(),
      height: (json['height'] as int).toDouble(),
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'width': width,
      'height': height,
      'url': url,
    };
  }
}

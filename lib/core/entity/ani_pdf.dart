class AniPdf {
  final int id;
  final String name;
  final String url;

  AniPdf({
    required this.id,
    required this.name,
    required this.url,
  });

  factory AniPdf.fromJson(Map<String, dynamic> json) {
    return AniPdf(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}

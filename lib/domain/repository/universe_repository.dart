import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/data/http_client.dart';

class UniverseRepository {
  const UniverseRepository({
    required HttpClient http,
  }) : _http = http;

  final HttpClient _http;

  Future<List<Universe>> getUniverses() async {
    final response = await _http.get(
      '/animes',
      responseParser: (JsonMap response) {
        print(response);
      },
    );
    return [];
  }

  Future<Universe?> getUniverseById(int id) {
    // Implementation needed
    throw UnimplementedError();
  }
}


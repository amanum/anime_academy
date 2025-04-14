import 'package:anime_academy/core/entity/universe.dart';
import 'package:anime_academy/data/http_client.dart';

class UniverseRepository {
  const UniverseRepository({
    required HttpClient http,
  }) : _http = http;

  final HttpClient _http;

  Future<List<Universe>> getUniverses() async {
    try {
      final response = await _http.get(
        '/animes',
        responseParser: (JsonMap response) {
          return response;
        },
      );
      
      final data = response.parsedData['data'] as List<dynamic>?;
      
      if (data == null) {
        return [];
      }
      
      return data.map((item) => Universe.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Ошибка при получении вселенных: $e');
      // В случае ошибки возвращаем пустой список
      return [];
    }
  }

  Future<Universe?> getUniverseById(int id) async {
    try {
      final response = await _http.get(
        '/animes/$id',
        responseParser: (JsonMap response) {
          return response;
        },
      );
      
      final data = response.parsedData['data'];
      
      if (data == null) {
        return null;
      }
      
      return Universe.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      print('Ошибка при получении вселенной по ID: $e');
      return null;
    }
  }
}


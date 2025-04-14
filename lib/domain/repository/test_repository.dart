import 'package:anime_academy/core/entity/ani_test.dart';
import 'package:anime_academy/data/http_client.dart';

/// Репозиторий для работы с тестами
class TestRepository {
  final HttpClient _http;

  const TestRepository({
    required HttpClient http,
  }) : _http = http;

  /// Получает список всех тестов
  Future<List<AniTest>> getTests() async {
    try {
      final response = await _http.get(
        '/tests',
        responseParser: (JsonMap response) {
          return response;
        },
      );
      
      // Проверяем наличие данных в ответе
      final data = response.parsedData['data'];
      if (data == null) {
        print('Ответ от API не содержит данных о тестах');
        return [];
      }
      
      // Преобразуем данные к нужному типу
      if (data is! List) {
        print('Данные о тестах не являются списком: $data');
        return [];
      }
      
      // Преобразуем список JSON в список объектов AniTest
      return data
          .map((item) {
            try {
              return AniTest.fromJson(item as Map<String, dynamic>);
            } catch (e) {
              print('Ошибка при преобразовании теста: $e, данные: $item');
              return null;
            }
          })
          .whereType<AniTest>() // Фильтруем null значения
          .toList();
    } catch (e) {
      print('Ошибка при получении тестов: $e');
      // В случае ошибки возвращаем пустой список
      return [];
    }
  }
} 
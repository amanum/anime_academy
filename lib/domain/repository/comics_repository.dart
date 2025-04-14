import 'package:anime_academy/core/entity/comics.dart';
import 'package:anime_academy/data/http_client.dart';

/// Репозиторий для работы с комиксами
class ComicsRepository {
  final HttpClient _http;

  const ComicsRepository({
    required HttpClient http,
  }) : _http = http;

  /// Получает список всех комиксов
  Future<List<Comics>> getComics() async {
    try {
      final response = await _http.get(
        '/comics',
        responseParser: (JsonMap response) {
          return response;
        },
      );
      
      // Проверяем наличие данных в ответе
      final data = response.parsedData['data'];
      if (data == null) {
        print('Ответ от API не содержит данных о комиксах');
        return [];
      }
      
      // Преобразуем данные к нужному типу
      if (data is! List) {
        print('Данные о комиксах не являются списком: $data');
        return [];
      }
      
      // Преобразуем список JSON в список объектов Comics
      return data
          .map((item) {
            try {
              return Comics.fromJson(item as Map<String, dynamic>);
            } catch (e) {
              print('Ошибка при преобразовании комикса: $e, данные: $item');
              return null;
            }
          })
          .whereType<Comics>() // Фильтруем null значения
          .toList();
    } catch (e) {
      print('Ошибка при получении комиксов: $e');
      // В случае ошибки возвращаем пустой список
      return [];
    }
  }
} 
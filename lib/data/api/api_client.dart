import 'dart:convert';
import 'package:http/http.dart' as http;

/// Клиент для работы с API
class ApiClient {
  /// Базовый URL API
  final String baseUrl;
  
  /// HTTP клиент
  final http.Client _httpClient;
  
  /// Заголовки для запросов
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };
  
  ApiClient({
    required this.baseUrl,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();
  
  /// Добавляет токен авторизации в заголовки
  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }
  
  /// Удаляет токен авторизации из заголовков
  void removeAuthToken() {
    _headers.remove('Authorization');
  }
  
  /// Выполняет GET запрос
  /// 
  /// [endpoint] - эндпоинт API
  /// [queryParams] - дополнительные параметры запроса
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
      queryParameters: queryParams?.map((key, value) => MapEntry(key, value.toString())),
    );
    
    final response = await _httpClient.get(uri, headers: _headers);
    return _processResponse(response);
  }
  
  /// Выполняет POST запрос
  /// 
  /// [endpoint] - эндпоинт API
  /// [data] - данные для отправки
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await _httpClient.post(
      uri,
      headers: _headers,
      body: data != null ? jsonEncode(data) : null,
    );
    return _processResponse(response);
  }
  
  /// Выполняет PUT запрос
  /// 
  /// [endpoint] - эндпоинт API
  /// [data] - данные для отправки
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await _httpClient.put(
      uri,
      headers: _headers,
      body: data != null ? jsonEncode(data) : null,
    );
    return _processResponse(response);
  }
  
  /// Выполняет DELETE запрос
  /// 
  /// [endpoint] - эндпоинт API
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await _httpClient.delete(uri, headers: _headers);
    return _processResponse(response);
  }
  
  /// Обрабатывает ответ от сервера
  /// 
  /// Проверяет статус ответа и преобразует тело в JSON
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {};
      }
      
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      // Удаляем токен, так как он устарел
      removeAuthToken();
      throw Exception('Ошибка авторизации. Пожалуйста, войдите снова.');
    } else {
      throw Exception('Ошибка запроса: ${response.statusCode}, ${response.reasonPhrase}');
    }
  }
} 
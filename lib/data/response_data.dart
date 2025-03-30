import 'package:dio/dio.dart';

///Класс, который возвращает информацию об ответе [response]
///и данные тела ответа [parsedData], которые спарсили в изоляте
class ResponseData<T> {
  final Response<dynamic> response;
  final T parsedData;

  ResponseData({
    required this.response,
    required this.parsedData,
  });
}

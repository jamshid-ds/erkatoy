import 'package:dio/dio.dart';

class ApiClient {
  final String _baseUrl = 'http://test.eva.softex.uz/';

  Dio get getDio {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (statusCode) => statusCode != null,
    );
    return Dio(baseOptions);
  }

  Options _postOptions() => Options(headers: _headersOption);

  final Map<String, dynamic> _headersOption = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Options get postOptions => _postOptions();
}

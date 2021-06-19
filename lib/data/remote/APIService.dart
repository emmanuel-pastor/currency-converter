import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
class APIService {
  final http.Client _client;
  static const _timeoutSeconds = 10;

  APIService(this._client);

  factory APIService.defaultClient() => APIService(http.Client());

  static final _apiKey = dotenv.env['API_KEY']!;
  static const String _baseUrl = "alpha-vantage.p.rapidapi.com";
  static final Map<String, String> _headers = {
    "Accept": "application/json",
    "x-rapidapi-host": "alpha-vantage.p.rapidapi.com",
    "x-rapidapi-key": _apiKey,
    "useQueryString": "true",
  };

  Future<String> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    http.Response response = await _client
        .get(Uri.https(_baseUrl, endpoint, query), headers: _headers)
        .timeout(const Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw HttpException('${response.statusCode} http error');
    }
  }
}

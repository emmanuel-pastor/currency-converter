import 'dart:convert';

import '../APIService.dart';
import 'ExchangeRateEndpoint.dart';
import '../models/ExchangeRateDTO.dart';

class ExchangeRateEndpointImpl implements ExchangeRateEndpoint{
  APIService _service;

  ExchangeRateEndpointImpl(this._service);

  @override
  Future<ExchangeRateDTO> getExchangeRate(
      {required String fromCurrencyCode, required String toCurrencyCode}) async {

    try {
      final json = await _service.get(endpoint: "/query", query: {
        "to_currency": toCurrencyCode,
        "function": "CURRENCY_EXCHANGE_RATE",
        "from_currency": fromCurrencyCode
      });

      return ExchangeRateDTO.fromJson(jsonDecode(json));
    } on Exception {
      return Future.error('Error retrieving exchange rate');
    }
  }
}

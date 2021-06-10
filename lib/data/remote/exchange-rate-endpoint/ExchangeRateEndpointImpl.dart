import 'dart:convert';

import 'package:currency_converter/data/remote/exchange-rate-endpoint/FakeExchangeRateAPIService.dart';

import '../APIService.dart';
import '../models/ExchangeRateDTO.dart';

class ExchangeRateEndpointImpl {
  APIService _service;

  ExchangeRateEndpointImpl(this._service);

  factory ExchangeRateEndpointImpl.defaultInstance() {
    return ExchangeRateEndpointImpl(APIService.defaultClient());
  }

  factory ExchangeRateEndpointImpl.fake() {
    return ExchangeRateEndpointImpl(FakeExchangeRateAPIService.getInstance());
  }


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

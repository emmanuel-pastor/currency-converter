import 'dart:convert';
import 'dart:io';

import 'package:currency_converter/data/remote/exchange-rate-endpoint/FakeExchangeRateAPIService.dart';

import '../APIService.dart';
import '../models/ExchangeRateDTO.dart';

class ExchangeRateEndpoint {
  APIService _service;

  ExchangeRateEndpoint(this._service);

  factory ExchangeRateEndpoint.defaultInstance() {
    return ExchangeRateEndpoint(APIService.defaultClient());
  }

  factory ExchangeRateEndpoint.fake() {
    return ExchangeRateEndpoint(FakeExchangeRateAPIService.getInstance());
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
    } on HttpException catch(e) {
      throw e;
    }
  }
}

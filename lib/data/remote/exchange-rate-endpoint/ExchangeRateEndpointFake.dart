import 'dart:convert';

import 'package:currency_converter/data/remote/APIService.dart';
import 'package:currency_converter/data/remote/exchange-rate-endpoint/ExchangeRateEndpoint.dart';
import 'package:currency_converter/data/remote/models/ExchangeRateDTO.dart';

class ExchangeRateEndpointFake implements ExchangeRateEndpoint {
  ExchangeRateEndpointFake(APIService service);

  @override
  Future<ExchangeRateDTO> getExchangeRate(
      {required String fromCurrencyCode, required String toCurrencyCode}) {
    return Future.value(ExchangeRateDTO.fromJson(jsonDecode(getFakeJson(fromCurrencyCode, toCurrencyCode))));
  }

  String getFakeJson(String fromCurrencyCode, String toCurrencyCode) {
    return '{ "Realtime Currency Exchange Rate": { "1. From_Currency Code": "$fromCurrencyCode", "2. From_Currency Name": "United States Dollar", "3. To_Currency Code": "$toCurrencyCode", "4. To_Currency Name": "Japanese Yen", "5. Exchange Rate": "110.11100000", "6. Last Refreshed": "2021-06-04 10:11:50", "7. Time Zone": "UTC", "8. Bid Price": "110.10560000", "9. Ask Price": "110.11410000" } }';
  }
}

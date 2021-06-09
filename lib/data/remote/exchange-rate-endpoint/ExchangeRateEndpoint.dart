import '../models/ExchangeRateDTO.dart';

abstract class ExchangeRateEndpoint {
  Future<ExchangeRateDTO> getExchangeRate({required String fromCurrencyCode, required String toCurrencyCode});
}
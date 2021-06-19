import 'package:currency_converter/domain/models/exchange-rate/ExchangeRate.dart';
import 'package:currency_converter/domain/repositories/ExchangeRateRepository.dart';

class ConversionUseCase {
  final _repo;

  ConversionUseCase(ExchangeRateRepository this._repo);

  Future<double> convert(
      double amount,
      {required String fromCurrencyCode,
      required String toCurrencyCode}) async {
    ExchangeRate? exchangeRate;
    try {
      exchangeRate = await _repo.getExchangeRate(
          fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);
    } catch (e) {
      throw e;
    }

    final rate = exchangeRate?.rate;
    if (rate != null) {
      return Future<double>.value(amount * rate);
    } else {
      throw ExchangeRateRetrievalException();
    }
  }
}

class ExchangeRateRetrievalException implements Exception{}

import 'package:currency_converter/domain/repositories/ExchangeRateRepository.dart';

class ConversionUseCase {
  final _repo;

  ConversionUseCase(ExchangeRateRepository this._repo);

  Future<double> convert(
      double amount,
      {required String fromCurrencyCode,
      required String toCurrencyCode}) async {
    final exchangeRate = await _repo.getExchangeRate(
        fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);

    final rate = exchangeRate?.rate;
    if (rate != null) {
      return Future<double>.value(amount * rate);
    } else {
      throw Exception('Could not load the exchange rate');
    }
  }
}

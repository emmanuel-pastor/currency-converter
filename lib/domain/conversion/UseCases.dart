import 'package:currency_converter/repository/Repository.dart';

typedef ConversionUseCase = Future<double?> Function({required double amount, required String fromCurrencyCode, required String toCurrencyCode});
ConversionUseCase conversionUseCase(Repository repo) {
  return ({required double amount, required String fromCurrencyCode, required String toCurrencyCode}) async {
    final exchangeRate = await repo.getExchangeRate(fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);

    final rate = exchangeRate?.exchangeRate;
    if(rate != null) {
      return Future<double>.value(amount * rate);
    } else {
      throw Exception('Could not load the exchange rate');
    }
  };
}

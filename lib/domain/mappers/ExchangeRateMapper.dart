import 'package:currency_converter/data/local/models/ExchangeRateEntity.dart';
import 'package:currency_converter/data/remote/models/ExchangeRateDTO.dart';
import 'package:currency_converter/domain/models/ExchangeRate.dart';

class ExchangeRateMapper {
  static ExchangeRate fromEntity(ExchangeRateEntity entity) {
    return ExchangeRate(entity.fromCurrencyCode, entity.fromCurrencyName, entity.toCurrencyCode,
        entity.toCurrencyName, entity.exchangeRate);
  }

  static ExchangeRateEntity toEntity(ExchangeRate exchangeRate) {
    return ExchangeRateEntity(
        fromCurrencyCode: exchangeRate.fromCurrencyCode,
        fromCurrencyName: exchangeRate.fromCurrencyName,
        toCurrencyCode: exchangeRate.toCurrencyCode,
        toCurrencyName: exchangeRate.toCurrencyName,
        exchangeRate: exchangeRate.rate);
  }

  static ExchangeRate fromDTO(ExchangeRateDTO dto) {
    return ExchangeRate(
        dto.realtimeCurrencyExchangeRate.fromCurrencyCode,
        dto.realtimeCurrencyExchangeRate.fromCurrencyName,
        dto.realtimeCurrencyExchangeRate.toCurrencyCode,
        dto.realtimeCurrencyExchangeRate.toCurrencyName,
        double.parse(dto.realtimeCurrencyExchangeRate.exchangeRate));
  }

  static ExchangeRateDTO toDTO(ExchangeRate exchangeRate) {
    return ExchangeRateDTO(
        realtimeCurrencyExchangeRate: RealtimeCurrencyExchangeRate(
      fromCurrencyCode: exchangeRate.fromCurrencyCode,
      fromCurrencyName: exchangeRate.fromCurrencyName,
      toCurrencyCode: exchangeRate.toCurrencyCode,
      toCurrencyName: exchangeRate.toCurrencyName,
      exchangeRate: exchangeRate.rate.toString(),
      lastRefreshed: DateTime.now(),
      timeZone: DateTime.now().timeZoneName,
      bidPrice: "",
      askPrice: "",
    ));
  }
}

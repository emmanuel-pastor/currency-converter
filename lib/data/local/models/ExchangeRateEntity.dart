import 'package:currency_converter/data/local/StringConstants.dart';

class ExchangeRateEntity {
  var id;
  final String fromCurrencyCode;
  final String fromCurrencyName;
  final String toCurrencyCode;
  final String toCurrencyName;
  final double rate;

  ExchangeRateEntity({
    String? this.id,
    required this.fromCurrencyCode,
    required this.fromCurrencyName,
    required this.toCurrencyCode,
    required this.toCurrencyName,
    required this.rate,
  }) {
    if (id == null) {
      id = this.fromCurrencyCode + this.toCurrencyCode;
    }
  }

  Map<String, dynamic> toMap() {
    var map = {
      StringConstants.from_currency_code: fromCurrencyCode,
      StringConstants.from_currency_name: fromCurrencyName,
      StringConstants.to_currency_code: toCurrencyCode,
      StringConstants.to_currency_name: toCurrencyName,
      StringConstants.rate: rate
    };
    if (id != null) map[StringConstants.id] = id!;

    return map;
  }

  factory ExchangeRateEntity.fromMap(Map<String, dynamic> map) => ExchangeRateEntity(
        id: map[StringConstants.id],
        fromCurrencyCode: map[StringConstants.from_currency_code],
        fromCurrencyName: map[StringConstants.from_currency_name],
        toCurrencyCode: map[StringConstants.to_currency_code],
        toCurrencyName: map[StringConstants.to_currency_name],
        rate: map[StringConstants.rate],
      );

  @override
  String toString() {
    return 'ExchangeRateEntity {id: $id, fromCurrencyCode: $fromCurrencyCode, fromCurrencyName: $fromCurrencyName, toCurrencyCode: $toCurrencyCode, toCurrencyName: $toCurrencyName, exchangeRate: $rate}';
  }
}

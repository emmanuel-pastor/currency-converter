import 'package:currency_converter/data/local/DBStrings.dart';

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
      DBStrings.from_currency_code: fromCurrencyCode,
      DBStrings.from_currency_name: fromCurrencyName,
      DBStrings.to_currency_code: toCurrencyCode,
      DBStrings.to_currency_name: toCurrencyName,
      DBStrings.rate: rate
    };
    if (id != null) map[DBStrings.id] = id!;

    return map;
  }

  factory ExchangeRateEntity.fromMap(Map<String, dynamic> map) => ExchangeRateEntity(
        id: map[DBStrings.id],
        fromCurrencyCode: map[DBStrings.from_currency_code],
        fromCurrencyName: map[DBStrings.from_currency_name],
        toCurrencyCode: map[DBStrings.to_currency_code],
        toCurrencyName: map[DBStrings.to_currency_name],
        rate: map[DBStrings.rate],
      );

  @override
  String toString() {
    return 'ExchangeRateEntity {id: $id, fromCurrencyCode: $fromCurrencyCode, fromCurrencyName: $fromCurrencyName, toCurrencyCode: $toCurrencyCode, toCurrencyName: $toCurrencyName, exchangeRate: $rate}';
  }
}

class ExchangeRate {
  final String fromCurrencyCode;
  final String fromCurrencyName;
  final String toCurrencyCode;
  final String toCurrencyName;
  final double rate;

  ExchangeRate(
      this.fromCurrencyCode,
      this.fromCurrencyName,
      this.toCurrencyCode,
      this.toCurrencyName,
      this.rate,);

  @override
  String toString() {
    return 'ExchangeRateEntity {fromCurrencyCode: $fromCurrencyCode, fromCurrencyName: $fromCurrencyName, toCurrencyCode: $toCurrencyCode, toCurrencyName: $toCurrencyName, exchangeRate: $rate}';
  }
}
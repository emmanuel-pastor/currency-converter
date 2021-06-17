
class ExchangeRateDTO {
  ExchangeRateDTO({
    required this.realtimeCurrencyExchangeRate,
  });

  RealtimeCurrencyExchangeRate realtimeCurrencyExchangeRate;

  factory ExchangeRateDTO.fromJson(Map<String, dynamic> json) => ExchangeRateDTO(
    realtimeCurrencyExchangeRate: RealtimeCurrencyExchangeRate.fromJson(json["Realtime Currency Exchange Rate"]),
  );

  Map<String, dynamic> toJson() => {
    "Realtime Currency Exchange Rate": realtimeCurrencyExchangeRate.toJson(),
  };
}

class RealtimeCurrencyExchangeRate {
  RealtimeCurrencyExchangeRate({
    required this.fromCurrencyCode,
    required this.fromCurrencyName,
    required this.toCurrencyCode,
    required this.toCurrencyName,
    required this.exchangeRate,
    required this.lastRefreshed,
    required this.timeZone,
    required this.bidPrice,
    required this.askPrice,
  });

  String fromCurrencyCode;
  String fromCurrencyName;
  String toCurrencyCode;
  String toCurrencyName;
  String exchangeRate;
  DateTime lastRefreshed;
  String timeZone;
  String bidPrice;
  String askPrice;

  factory RealtimeCurrencyExchangeRate.fromJson(Map<String, dynamic> json) => RealtimeCurrencyExchangeRate(
    fromCurrencyCode: json["1. From_Currency Code"],
    fromCurrencyName: json["2. From_Currency Name"],
    toCurrencyCode: json["3. To_Currency Code"],
    toCurrencyName: json["4. To_Currency Name"],
    exchangeRate: json["5. Exchange Rate"],
    lastRefreshed: DateTime.parse(json["6. Last Refreshed"]),
    timeZone: json["7. Time Zone"],
    bidPrice: json["8. Bid Price"],
    askPrice: json["9. Ask Price"],
  );

  Map<String, dynamic> toJson() => {
    "1. From_Currency Code": fromCurrencyCode,
    "2. From_Currency Name": fromCurrencyName,
    "3. To_Currency Code": toCurrencyCode,
    "4. To_Currency Name": toCurrencyName,
    "5. Exchange Rate": exchangeRate,
    "6. Last Refreshed": lastRefreshed.toIso8601String(),
    "7. Time Zone": timeZone,
    "8. Bid Price": bidPrice,
    "9. Ask Price": askPrice,
  };
}
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter/data/local/exchange-rate-dao/ExchangeRateDAO.dart';
import 'package:currency_converter/data/remote/exchange-rate-endpoint/ExchangeRateEndpoint.dart';
import 'package:currency_converter/domain/mappers/ExchangeRateMapper.dart';
import 'package:currency_converter/domain/models/ExchangeRate.dart';

class ExchangeRateRepository {
  ExchangeRateDAO _dao;
  ExchangeRateEndpoint _endpoint;
  late Connectivity _connectivity;

  ExchangeRateRepository(this._dao, this._endpoint) {
    _connectivity = Connectivity();
  }

  Future<ExchangeRate?> getExchangeRate(
      {required String fromCurrencyCode, required String toCurrencyCode}) async {
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();

    ExchangeRate? exchangeRate;
    if (connectivityResult == ConnectivityResult.none) {
      // Get the exchange rate from the database
      final exchangeRateEntity = await _dao.getExchangeRate(
          fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);

      if (exchangeRateEntity != null) {
        exchangeRate = ExchangeRateMapper.fromEntity(exchangeRateEntity);
      }
    } else {
      // Get the exchange rate from the API
      final exchangeRateDTO = await _endpoint.getExchangeRate(
          fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);

      exchangeRate = ExchangeRateMapper.fromDTO(exchangeRateDTO);

      // Update the database with the new exchange rate
      _dao.insert(ExchangeRateMapper.toEntity(exchangeRate));
    }

    return Future<ExchangeRate?>.value(exchangeRate);
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:currency_converter/data/local/exchange-rate-dao/ExchangeRateDAO.dart';
import 'package:currency_converter/data/remote/exchange-rate-endpoint/ExchangeRateEndpoint.dart';
import 'package:currency_converter/domain/mappers/ExchangeRateMapper.dart';
import 'package:currency_converter/domain/models/ExchangeRate.dart';

class ExchangeRateRepository {
  ExchangeRateDAO _dao;
  ExchangeRateEndpoint _endpoint;
  late Connectivity _connectivity;
  ExchangeRate? _exchangeRate;

  ExchangeRateRepository(this._dao, this._endpoint) {
    _connectivity = Connectivity();
  }

  Future<ExchangeRate?> getExchangeRate(
      {required String fromCurrencyCode, required String toCurrencyCode}) async {
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();

    if (_exchangeRate == null) {
      if (connectivityResult == ConnectivityResult.none) {
        _exchangeRate = await _getExchangeRateFromDatabase(
            fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);
      } else {
        final dto = await _endpoint.getExchangeRate(
            fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);
        _exchangeRate = ExchangeRateMapper.fromDTO(dto);
      }
    }

    return Future<ExchangeRate?>.value(_exchangeRate);
  }

  Future<ExchangeRate?> _getExchangeRateFromDatabase(
      {required String fromCurrencyCode, required String toCurrencyCode}) async {
    final exchangeRateEntity = await _dao.getExchangeRate(
        fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);

    if (exchangeRateEntity != null) {
      return ExchangeRateMapper.fromEntity(exchangeRateEntity);
    } else {
      return null;
    }
  }
}

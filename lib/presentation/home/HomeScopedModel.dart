import 'package:currency_converter/domain/features/conversion/UseCases.dart';
import 'package:currency_converter/presentation/BaseScopedModel.dart';
import 'package:currency_converter/presentation/ViewError.dart';
import 'package:currency_converter/presentation/ViewState.dart';

class HomeScopedModel extends BaseScopedModel {
  final ConversionUseCase _conversionUseCase;

  HomeScopedModel(this._conversionUseCase);

  String _fromCurrencyCode = "EUR";
  String get fromCurrencyCode => _fromCurrencyCode;

  String _toCurrencyCode = "USD";
  String get toCurrencyCode => _toCurrencyCode;

  double _fromAmount = 0;
  double get fromAmount => _fromAmount;

  double _toAmount = 0;
  double get toAmount => _toAmount;
  
  ViewError<ErrorType> _error = ViewError(ErrorType.NONE, '');
  ViewError<ErrorType> get error => _error;

  _setFromCurrencyCode(String currencyCode) {
    _fromCurrencyCode = currencyCode;
    notifyListeners();
  }

  _setToCurrencyCode(String currencyCode) {
    _toCurrencyCode = currencyCode;
    notifyListeners();
  }

  _setFromAmount(double amount) {
    _fromAmount = amount;
    notifyListeners();
  }

  _setToAmount(double amount) {
    _toAmount = amount;
    notifyListeners();
  }

  _setErrorState(ErrorType errorType, [String message = '']) {
    _error = ViewError(errorType, message);
    setState(ViewState.ERROR);
    notifyListeners();
  }

  onAmountSubmitted(String amountStr) async {
    setState(ViewState.LOADING);

    var amount = double.tryParse(amountStr.trim().replaceAll(',', '.').replaceAll('', '0'));
    if (amount == null) {
      _setErrorState(ErrorType.PARSING, 'Could not parse the submitted amount');
      setState(ViewState.ERROR);
    } else {
      _setFromAmount(amount);

      _convertCurrencyAndUpdateState();
    }
  }

  onFromCurrencyChanged(String? currencyCode) {
    if (currencyCode == null) {
      _setErrorState(ErrorType.NO_ORIGIN_CURRENCY, 'No origin currency selected');
    } else {
      _onCurrencyChanged(currencyCode, _setFromCurrencyCode);
    }
  }

  onToCurrencyChanged(String? currencyCode) {
    if (currencyCode == null) {
      _setErrorState(ErrorType.NO_DESTINATION_CURRENCY, 'No destination currency selected');
    } else {
      _onCurrencyChanged(currencyCode, _setToCurrencyCode);
    }
  }

  _onCurrencyChanged(String currencyCode, Function(String) updateCurrencyCode) {
    setState(ViewState.LOADING);

    updateCurrencyCode(currencyCode);

    _convertCurrencyAndUpdateState();
  }

  _convertCurrencyAndUpdateState() async {
    try {
      final convertedAmount = await _conversionUseCase.convert(fromAmount,
          fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);
      _setToAmount(convertedAmount);

      setState(ViewState.READY);
    } on ExchangeRateRetrievalException {
      _setErrorState(ErrorType.RETRIEVAL, 'Could not retrieve the exchange rate\nTry again later');
    } catch (e) {
      _setErrorState(ErrorType.UNEXPECTED, 'Unexpected error : ${e.runtimeType}');
    }
  }
}

enum ErrorType {
  NONE,
  PARSING,
  NO_ORIGIN_CURRENCY,
  NO_DESTINATION_CURRENCY,
  RETRIEVAL,
  UNEXPECTED
}

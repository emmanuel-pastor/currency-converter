import 'package:currency_converter/domain/features/conversion/UseCases.dart';
import 'package:currency_converter/presentation/BaseScopedModel.dart';
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

  setFromCurrencyCode(String currencyCode) {
    _fromCurrencyCode = currencyCode;
    notifyListeners();
  }

  setToCurrencyCode(String currencyCode) {
    _toCurrencyCode = currencyCode;
    notifyListeners();
  }

  setFromAmount(double amount) {
    _fromAmount = amount;
    notifyListeners();
  }

  setToAmount(double amount) {
    _toAmount = amount;
    notifyListeners();
  }

  onAmountSubmitted(String amountStr) async {
    setState(ViewState.LOADING);

    var amount = double.tryParse(amountStr.replaceAll(',', '.'));
    if (amount == null) {
      setErrorMessage('Could not parse the submitted amount');
      setState(ViewState.ERROR);
    } else {
      setFromAmount(amount);

      _convertCurrencyAndUpdateState();
    }
  }

  onFromCurrencyChanged(String? currencyCode) {
    _onCurrencyChanged(currencyCode, setFromCurrencyCode);
  }

  onToCurrencyChanged(String? currencyCode) {
    _onCurrencyChanged(currencyCode, setToCurrencyCode);
  }

  _onCurrencyChanged(String? currencyCode, Function(String) updateCurrencyCode) {
    setState(ViewState.LOADING);

    if (currencyCode == null) {
      setErrorMessage('No origin currency selected');
      setState(ViewState.ERROR);
    } else {
      updateCurrencyCode(currencyCode);

      _convertCurrencyAndUpdateState();
    }
  }

  _convertCurrencyAndUpdateState() async {
    try {
      final convertedAmount = await _conversionUseCase.convert(fromAmount,
          fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);
      setToAmount(convertedAmount);

      setState(ViewState.READY);
    } catch (e) {
      setErrorMessage('Could not convert the submitted amount');
      setState(ViewState.ERROR);
    }
  }
}

import 'package:currency_converter/domain/features/conversion/UseCases.dart';
import 'package:currency_converter/presentation/ViewError.dart';
import 'package:currency_converter/presentation/ViewState.dart';
import 'package:mobx/mobx.dart';

part 'HomeViewModel.g.dart';

class HomeViewModel extends _HomeViewModel with _$HomeViewModel {
    HomeViewModel(ConversionUseCase conversionUseCase) {
      super._conversionUseCase = conversionUseCase;
    }
}

abstract class _HomeViewModel with Store {
  late ConversionUseCase _conversionUseCase;

  @observable
  ViewState state = ViewState.READY;

  @observable
  String fromCurrencyCode = "EUR";

  @observable
  String toCurrencyCode = "USD";

  @observable
  double fromAmount = 0;

  @observable
  double toAmount = 0;

  @observable
  ViewError<ErrorType> error = ViewError(ErrorType.NONE, '');

  @computed
  bool get hasError => state == ViewState.ERROR;

  @computed
  bool get hasParsingError => hasError && error.type == ErrorType.PARSING;

  @action
  _setErrorState(ErrorType errorType, [String message = '']) {
    error = ViewError(errorType, message);
    state = ViewState.ERROR;
  }

  onRetry() {
    onAmountSubmitted(fromAmount.toString());
  }

  @action
  onAmountSubmitted(String amountStr) async {
    state = ViewState.LOADING;

    var amount = amountStr.isEmpty ? 0.0 : double.tryParse(amountStr.trim().replaceAll(',', '.'));
    if (amount == null) {
      _setErrorState(ErrorType.PARSING, 'Could not parse the submitted amount');
    } else {
      fromAmount = amount;

      _convertCurrencyAndUpdateState();
    }
  }

  onFromCurrencyChanged(String? currencyCode) {
    if (currencyCode == null) {
      _setErrorState(ErrorType.NO_ORIGIN_CURRENCY, 'No origin currency selected');
    } else {
      _onCurrencyChanged(currencyCode, true);
    }
  }

  onToCurrencyChanged(String? currencyCode) {
    if (currencyCode == null) {
      _setErrorState(ErrorType.NO_DESTINATION_CURRENCY, 'No destination currency selected');
    } else {
      _onCurrencyChanged(currencyCode, false);
    }
  }

  @action
  _onCurrencyChanged(String currencyCode, bool shouldConvertFromCurrencyCode) {
    state = ViewState.LOADING;

    if (shouldConvertFromCurrencyCode) {
      fromCurrencyCode = currencyCode;
    } else {
      toCurrencyCode = currencyCode;
    }

    _convertCurrencyAndUpdateState();
  }

  @action
  _convertCurrencyAndUpdateState() async {
    try {
      final convertedAmount = await _conversionUseCase.convert(fromAmount,
          fromCurrencyCode: fromCurrencyCode, toCurrencyCode: toCurrencyCode);
      toAmount = convertedAmount;

      state = ViewState.READY;
    } on ExchangeRateRetrievalException {
      _setErrorState(ErrorType.RETRIEVAL, 'Could not retrieve the exchange rate');
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeViewModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModel, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_HomeViewModel.hasError'))
      .value;
  Computed<bool>? _$hasParsingErrorComputed;

  @override
  bool get hasParsingError =>
      (_$hasParsingErrorComputed ??= Computed<bool>(() => super.hasParsingError,
              name: '_HomeViewModel.hasParsingError'))
          .value;

  late final _$stateAtom = Atom(name: '_HomeViewModel.state', context: context);

  @override
  ViewState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ViewState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fromCurrencyCodeAtom =
      Atom(name: '_HomeViewModel.fromCurrencyCode', context: context);

  @override
  String get fromCurrencyCode {
    _$fromCurrencyCodeAtom.reportRead();
    return super.fromCurrencyCode;
  }

  @override
  set fromCurrencyCode(String value) {
    _$fromCurrencyCodeAtom.reportWrite(value, super.fromCurrencyCode, () {
      super.fromCurrencyCode = value;
    });
  }

  late final _$toCurrencyCodeAtom =
      Atom(name: '_HomeViewModel.toCurrencyCode', context: context);

  @override
  String get toCurrencyCode {
    _$toCurrencyCodeAtom.reportRead();
    return super.toCurrencyCode;
  }

  @override
  set toCurrencyCode(String value) {
    _$toCurrencyCodeAtom.reportWrite(value, super.toCurrencyCode, () {
      super.toCurrencyCode = value;
    });
  }

  late final _$fromAmountAtom =
      Atom(name: '_HomeViewModel.fromAmount', context: context);

  @override
  double get fromAmount {
    _$fromAmountAtom.reportRead();
    return super.fromAmount;
  }

  @override
  set fromAmount(double value) {
    _$fromAmountAtom.reportWrite(value, super.fromAmount, () {
      super.fromAmount = value;
    });
  }

  late final _$toAmountAtom =
      Atom(name: '_HomeViewModel.toAmount', context: context);

  @override
  double get toAmount {
    _$toAmountAtom.reportRead();
    return super.toAmount;
  }

  @override
  set toAmount(double value) {
    _$toAmountAtom.reportWrite(value, super.toAmount, () {
      super.toAmount = value;
    });
  }

  late final _$errorAtom = Atom(name: '_HomeViewModel.error', context: context);

  @override
  ViewError<ErrorType> get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(ViewError<ErrorType> value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$onAmountSubmittedAsyncAction =
      AsyncAction('_HomeViewModel.onAmountSubmitted', context: context);

  @override
  Future onAmountSubmitted(String amountStr) {
    return _$onAmountSubmittedAsyncAction
        .run(() => super.onAmountSubmitted(amountStr));
  }

  late final _$_convertCurrencyAndUpdateStateAsyncAction = AsyncAction(
      '_HomeViewModel._convertCurrencyAndUpdateState',
      context: context);

  @override
  Future _convertCurrencyAndUpdateState() {
    return _$_convertCurrencyAndUpdateStateAsyncAction
        .run(() => super._convertCurrencyAndUpdateState());
  }

  late final _$_HomeViewModelActionController =
      ActionController(name: '_HomeViewModel', context: context);

  @override
  dynamic _setErrorState(ErrorType errorType, [String message = '']) {
    final _$actionInfo = _$_HomeViewModelActionController.startAction(
        name: '_HomeViewModel._setErrorState');
    try {
      return super._setErrorState(errorType, message);
    } finally {
      _$_HomeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _onCurrencyChanged(
      String currencyCode, bool shouldConvertFromCurrencyCode) {
    final _$actionInfo = _$_HomeViewModelActionController.startAction(
        name: '_HomeViewModel._onCurrencyChanged');
    try {
      return super
          ._onCurrencyChanged(currencyCode, shouldConvertFromCurrencyCode);
    } finally {
      _$_HomeViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
fromCurrencyCode: ${fromCurrencyCode},
toCurrencyCode: ${toCurrencyCode},
fromAmount: ${fromAmount},
toAmount: ${toAmount},
error: ${error},
hasError: ${hasError},
hasParsingError: ${hasParsingError}
    ''';
  }
}

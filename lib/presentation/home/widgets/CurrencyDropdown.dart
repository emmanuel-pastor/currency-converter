import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final String disabledCurrency;
  final Function(String?)? onCurrencyChanged;

  const CurrencyDropdown(
      {Key? key, this.selectedCurrency = 'EUR', this.disabledCurrency = '', this.onCurrencyChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: this.selectedCurrency,
        elevation: 8,
        onChanged: (String? value) => onCurrencyChanged?.call(value),
        items: <String>['CNY', 'EUR', 'JPY', 'RUB', 'USD']
            .where((element) => element != disabledCurrency)
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}

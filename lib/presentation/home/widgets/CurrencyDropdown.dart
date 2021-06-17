import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrencyCode;
  final String disabledCurrencyCode;
  final Function(String?)? onCurrencyChanged;

  const CurrencyDropdown(
      {Key? key, this.selectedCurrencyCode = 'EUR', this.disabledCurrencyCode = '', this.onCurrencyChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: this.selectedCurrencyCode,
        elevation: 8,
        onChanged: (String? value) => onCurrencyChanged?.call(value),
        items: <String>['CNY', 'EUR', 'JPY', 'RUB', 'USD']
            .where((element) => element != disabledCurrencyCode)
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList());
  }
}

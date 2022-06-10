import 'package:currency_converter/presentation/BasePage.dart';
import 'package:currency_converter/presentation/home/HomeViewModel.dart';
import 'package:currency_converter/presentation/home/widgets/AmountTextField.dart';
import 'package:currency_converter/presentation/home/widgets/ConversionResultText.dart';
import 'package:currency_converter/presentation/home/widgets/CurrencyDropdown.dart';
import 'package:currency_converter/presentation/home/widgets/DefaultErrorWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeViewModel>(
      builder: (context, viewModel) => Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CurrencyDropdown(
                  selectedCurrencyCode: viewModel.fromCurrencyCode,
                  disabledCurrencyCode: viewModel.toCurrencyCode,
                  onCurrencyChanged: viewModel.onFromCurrencyChanged,
                ),
                const SizedBox(height: 20),
                AmountTextField(
                    fromCurrencyCode: viewModel.fromCurrencyCode,
                    hasParsingError: viewModel.hasParsingError,
                    errorMessage: viewModel.error.message,
                    onAmountSubmitted: viewModel.onAmountSubmitted),
                const SizedBox(height: 20),
                CurrencyDropdown(
                  selectedCurrencyCode: viewModel.toCurrencyCode,
                  disabledCurrencyCode: viewModel.fromCurrencyCode,
                  onCurrencyChanged: viewModel.onToCurrencyChanged,
                ),
                const SizedBox(height: 20),
                ConversionResultText(
                  state: viewModel.state,
                  result: viewModel.toAmount,
                ),
                const SizedBox(height: 20),
                DefaultErrorWidget(hasError: viewModel.hasError, error: viewModel.error, onRetry: viewModel.onRetry)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

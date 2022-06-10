import 'package:currency_converter/presentation/BasePage.dart';
import 'package:currency_converter/presentation/ViewState.dart';
import 'package:currency_converter/presentation/home/HomeViewModel.dart';
import 'package:currency_converter/presentation/home/widgets/CurrencyDropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                SizedBox(height: 20),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Amount in ${viewModel.fromCurrencyCode}',
                    errorText: viewModel.state == ViewState.ERROR && viewModel.error.type == ErrorType.PARSING
                        ? '${viewModel.error.message}'
                        : null,
                    border: OutlineInputBorder(),
                    suffixIcon: viewModel.state == ViewState.ERROR && viewModel.error.type == ErrorType.PARSING
                        ? Icon(
                            Icons.error,
                            color: Colors.red,
                          )
                        : null,
                  ),
                  onFieldSubmitted: (String value) async {
                    viewModel.onAmountSubmitted(value);
                  },
                ),
                SizedBox(height: 20),
                CurrencyDropdown(
                  selectedCurrencyCode: viewModel.toCurrencyCode,
                  disabledCurrencyCode: viewModel.fromCurrencyCode,
                  onCurrencyChanged: viewModel.onToCurrencyChanged,
                ),
                SizedBox(height: 20),
                if (viewModel.state == ViewState.LOADING)
                  CircularProgressIndicator()
                else if (viewModel.state == ViewState.READY)
                  Text(
                    viewModel.toAmount.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                SizedBox(height: 20),
                if (viewModel.state == ViewState.ERROR && viewModel.error.type != ErrorType.PARSING)
                  Column(
                    children: [
                      Text(
                        viewModel.error.message,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      if (viewModel.error.type == ErrorType.RETRIEVAL || viewModel.error.type == ErrorType.UNEXPECTED)
                        TextButton(
                          onPressed: viewModel.onRetry,
                          child: Text('RETRY'),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

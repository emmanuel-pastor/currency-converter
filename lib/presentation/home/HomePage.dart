import 'package:currency_converter/presentation/BasePage.dart';
import 'package:currency_converter/presentation/ViewState.dart';
import 'package:currency_converter/presentation/home/HomeScopedModel.dart';
import 'package:currency_converter/presentation/home/widgets/CurrencyDropdown.dart';
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
    return BasePage<HomeScopedModel>(
      initialState: ViewState.READY,
      builder: (context, child, scopedModel) => Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CurrencyDropdown(
                  selectedCurrencyCode: scopedModel.fromCurrencyCode,
                  disabledCurrencyCode: scopedModel.toCurrencyCode,
                  onCurrencyChanged: scopedModel.onFromCurrencyChanged,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Amount in ${scopedModel.fromCurrencyCode}',
                    errorText: scopedModel.state == ViewState.ERROR &&
                            scopedModel.error.type == ErrorType.PARSING
                        ? '${scopedModel.error.message}'
                        : null,
                    border: OutlineInputBorder(),
                    suffixIcon: scopedModel.state == ViewState.ERROR &&
                            scopedModel.error.type == ErrorType.PARSING
                        ? Icon(
                            Icons.error,
                            color: Colors.red,
                          )
                        : null,
                  ),
                  onFieldSubmitted: (String value) async {
                    scopedModel.onAmountSubmitted(value);
                  },
                ),
                SizedBox(height: 20),
                CurrencyDropdown(
                  selectedCurrencyCode: scopedModel.toCurrencyCode,
                  disabledCurrencyCode: scopedModel.fromCurrencyCode,
                  onCurrencyChanged: scopedModel.onToCurrencyChanged,
                ),
                SizedBox(height: 20),
                if (scopedModel.state == ViewState.LOADING)
                  CircularProgressIndicator()
                else if (scopedModel.state == ViewState.READY)
                  Text(
                    scopedModel.toAmount.toStringAsFixed(2),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                SizedBox(height: 20),
                if (scopedModel.state == ViewState.ERROR &&
                    scopedModel.error.type != ErrorType.PARSING)
                  Column(
                    children: [
                      Text(
                        scopedModel.error.message,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: scopedModel.onRetry,
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

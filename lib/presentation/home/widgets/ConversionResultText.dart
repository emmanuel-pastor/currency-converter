import 'package:currency_converter/presentation/ViewState.dart';
import 'package:flutter/material.dart';

class ConversionResultText extends StatelessWidget {
  final ViewState state;
  final double result;

  const ConversionResultText({Key? key, required this.state, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == ViewState.LOADING)
      return const CircularProgressIndicator();
    else if (state == ViewState.READY)
      return Text(
        result.toStringAsFixed(2),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      );
    else
      return const SizedBox();
  }
}

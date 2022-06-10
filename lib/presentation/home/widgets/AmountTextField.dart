import 'package:flutter/material.dart';

class AmountTextField extends StatefulWidget {
  final String fromCurrencyCode;
  final bool hasParsingError;
  final String errorMessage;
  final Function(String amount) onAmountSubmitted;

  const AmountTextField(
      {Key? key,
      required this.fromCurrencyCode,
      required this.hasParsingError,
      required this.errorMessage,
      required this.onAmountSubmitted})
      : super(key: key);

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
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
    return TextFormField(
      controller: _controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Amount in ${widget.fromCurrencyCode}',
        errorText: widget.hasParsingError ? '${widget.errorMessage}' : null,
        border: const OutlineInputBorder(),
        suffixIcon: widget.hasParsingError
            ? const Icon(
                Icons.error,
                color: Colors.red,
              )
            : null,
      ),
      onFieldSubmitted: (String value) async {
        widget.onAmountSubmitted(value);
      },
    );
  }
}

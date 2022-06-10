import 'package:currency_converter/presentation/ViewError.dart';
import 'package:currency_converter/presentation/home/HomeViewModel.dart';
import 'package:flutter/material.dart';

class DefaultErrorWidget extends StatelessWidget {
  final bool hasError;
  final ViewError error;
  final Function() onRetry;

  const DefaultErrorWidget({Key? key, required this.hasError, required this.error, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error.type != ErrorType.PARSING)
      return Column(
        children: [
          Text(
            error.message,
            style: TextStyle(color: Colors.red, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          if (error.type == ErrorType.RETRIEVAL || error.type == ErrorType.UNEXPECTED)
            TextButton(
              onPressed: onRetry,
              child: const Text('RETRY'),
            ),
        ],
      );
    else
      return const SizedBox();
  }
}

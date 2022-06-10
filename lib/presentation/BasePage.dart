import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../ServiceLocator.dart';

class BasePage<T extends Object> extends StatelessWidget {
  final T viewModel = locator<T>();

  // return true to pop the current page from the stack, return false otherwise
  final Future<bool> Function(T)? onPopButtonClicked;
  final Widget Function(BuildContext context, T viewModel) builder;

  BasePage({Key? key, required this.builder, this.onPopButtonClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (buildContext) => WillPopScope(
              child: builder(buildContext, viewModel),
              onWillPop: onPopButtonClicked == null ? null : () async => await onPopButtonClicked!(viewModel),
            ));
  }
}

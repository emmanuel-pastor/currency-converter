import 'package:currency_converter/presentation/ViewState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ServiceLocator.dart';
import 'BaseScopedModel.dart';

class BasePage<T extends BaseScopedModel> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T)? onScopedModelReady;
  final ViewState? _initialState;

  BasePage(
      {required ScopedModelDescendantBuilder<T> builder, this.onScopedModelReady, ViewState? initialState})
      : this._builder = builder,
        this._initialState = initialState;

  @override
  _BasePageState<T> createState() => _BasePageState<T>();
}

class _BasePageState<T extends BaseScopedModel> extends State<BasePage<T>> {
  T _scopedModel = locator<T>();

  @override
  void initState() {
    if (widget.onScopedModelReady != null) {
      widget.onScopedModelReady!(_scopedModel);
    }
    if (widget._initialState != null) {
      _scopedModel.setState(widget._initialState!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _scopedModel, child: ScopedModelDescendant<T>(builder: widget._builder));
  }
}

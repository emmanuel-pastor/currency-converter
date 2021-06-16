import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ServiceLocator.dart';

class BasePage<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T)? onScopedModelReady;

  BasePage({required ScopedModelDescendantBuilder<T> builder, this.onScopedModelReady})
      : this._builder = builder;

  @override
  _BasePageState<T> createState() => _BasePageState<T>();
}

class _BasePageState<T extends Model> extends State<BasePage<T>> {
  T _scopedModel = locator<T>();

  @override
  void initState() {
    if (widget.onScopedModelReady != null) {
      widget.onScopedModelReady!(_scopedModel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _scopedModel, child: ScopedModelDescendant<T>(builder: widget._builder));
  }
}

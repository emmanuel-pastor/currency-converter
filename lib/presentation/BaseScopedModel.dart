import 'package:currency_converter/presentation/ViewState.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseScopedModel extends Model {
  ViewState _state = ViewState.LOADING;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
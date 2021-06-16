import 'package:currency_converter/presentation/ViewState.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseScopedModel extends Model {
  ViewState _state = ViewState.LOADING;
  ViewState get state => _state;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
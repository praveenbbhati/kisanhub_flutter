import 'package:kisanhub_assignment/data/rest_ds.dart';
import 'package:kisanhub_assignment/models/LoginRequest.dart';
import 'package:kisanhub_assignment/models/LoginResponse.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(LoginResponse user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestData api =  RestData();
  LoginScreenPresenter(this._view);

  doLogin(LoginRequest loginRequest) {
    api.login(loginRequest)
      .then((LoginResponse loginResponse) {
        _view.onLoginSuccess(loginResponse);
      })
      .catchError((Exception error) => _view.onLoginError(error.toString()));
  }
}
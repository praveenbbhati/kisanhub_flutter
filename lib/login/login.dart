import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisanhub_assignment/auth.dart';
import 'package:kisanhub_assignment/models/LoginResponse.dart';
import 'package:kisanhub_assignment/utils/validator.dart';
import 'package:kisanhub_assignment/models/LoginRequest.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget{ 
 
  LoginPage({Key key}) : super (key:key);

  @override
  _LoginPageState createState() =>_LoginPageState();

}

class _LoginPageState extends State<LoginPage> 
      implements LoginScreenContract,AuthStateListener{

  GlobalKey<FormState> _key = GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  LoginRequest _loginRequest = LoginRequest();
  bool _isLoading = false;
  BuildContext _ctx;
  LoginScreenPresenter _loginScreenPresenter;

  _LoginPageState(){
    _loginScreenPresenter = LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  Widget getFormUI(){

    final emailField = TextFormField(
      obscureText: false,
      style: TextStyle(fontSize: 20.0),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
      validator: Validator().validateEmail,
      onSaved: (String value){
        _loginRequest.username = value;
      },
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
      validator: Validator().validatePassword,
      onSaved: (String value){
        _loginRequest.password = value;
      },
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffC6D32D),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _sendToServer,
        child: Text("Login",
            textAlign: TextAlign.center,
            style:TextStyle(fontSize: 20.0,color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 155.0,
          child: Image.asset(
            "assets/kisanhub_logo.png",
          ),
        ),
        SizedBox(height: 45.0),
        emailField,
        SizedBox(height: 25.0),
        passwordField,
        SizedBox(
          height: 35.0,
        ),
        _isLoading ? new CircularProgressIndicator() : loginButon,
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  void _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      setState(() => _isLoading = true);
      _key.currentState.save();
      _loginScreenPresenter.doLogin(_loginRequest);
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
 
  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context){
    _ctx = context;
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: new Form(
              key: _key,
              autovalidate: _validate,
              child: getFormUI(),
            ) 
          ),
        ),
      ),
    );   
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(LoginResponse loginResponse) {
    _showSnackBar(loginResponse.usertoken);
    setState(() => _isLoading = false);
    setUserLogin(loginResponse.usertoken);
  }

  Future<void> setUserLogin(String auth_token) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("auth_token", auth_token);
    pref.setBool("is_login", true);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
 }

  @override
  void onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/home");
  }

}
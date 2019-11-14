import 'package:flutter/material.dart';
import 'utils/Validator.dart';
import 'models/LoginRequest.dart';

class LoginPage extends StatefulWidget{
 
  LoginPage({Key key}) : super (key:key);

  @override
  _LoginPageState createState() =>_LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  LoginRequest _loginRequest = LoginRequest();


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
        _loginRequest.email = value;
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
        loginButon,
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();
      print("Email ${_loginRequest.email}");
      print("Password ${_loginRequest.password}");
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
 


  @override
  Widget build(BuildContext context){

    return Scaffold(
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

}
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisanhub_assignment/utils/network_util.dart';
import 'package:kisanhub_assignment/models/LoginRequest.dart';
import 'package:kisanhub_assignment/models/LoginResponse.dart';
import 'package:kisanhub_assignment/models/ActivityResponse.dart';

class RestData{
  NetworkUtil networkUtil = NetworkUtil();
  static final BASE_URL = "https://demo5954819.mockable.io/kisanhub";
  static final LOGIN_URL = BASE_URL + "/login";
  static final ACTIVITY_URL = BASE_URL + "/activities";
  

  Future<LoginResponse> login(LoginRequest loginRequest){
      return networkUtil.post(LOGIN_URL,body: {
        "username" : loginRequest.username,
        "password" : loginRequest.password    
      }).then( (dynamic res){
        print(res.toString());
        return LoginResponse.map(res); 
      });
  }


  Future<ActivityResponse> getActivities(){
    return getToken().then((dynamic res){
        return networkUtil.get(ACTIVITY_URL, 
          res.toString()
        ).then((dynamic res){
          print(res.toString());
          return ActivityResponse.fromJson(res);
      });
    });
    
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("auth_token"); 
  }

}
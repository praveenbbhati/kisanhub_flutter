import 'package:flutter/material.dart';
import 'login/login.dart';
import 'home/home.dart';

final routes = {
  '/login' : (BuildContext context) => LoginPage(),
  '/home' : (BuildContext context) => HomePage(), 
  '/' : (BuildContext context) => LoginPage() ,
};
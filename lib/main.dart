import 'package:flutter/material.dart';
import 'routes.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  static Map<int, Color> color = {
    50:Color.fromRGBO(198,211,45, .1),
    100:Color.fromRGBO(198,211,45, .2),
    200:Color.fromRGBO(198,211,45, .3),
    300:Color.fromRGBO(198,211,45, .4),
    400:Color.fromRGBO(198,211,45, .5),
    500:Color.fromRGBO(198,211,45, .6),
    600:Color.fromRGBO(198,211,45, .7),
    700:Color.fromRGBO(198,211,45, .8),
    800:Color.fromRGBO(198,211,45, .9),
    900:Color.fromRGBO(198,211,45, 1),
  };

  MaterialColor colorCustom = MaterialColor(0xFFC6D32D, color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,      
      title: 'Kisan Hub',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      routes: routes,
    );
  }
}

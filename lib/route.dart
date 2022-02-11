
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/countryDetail.dart';

class RouteGenerator {
  static Route<dynamic> ?generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/home': {
        return MaterialPageRoute(builder: (_) => MyHomePage());
      }

      case '/country':{
        return MaterialPageRoute(builder: (context) => countryDetail(settings.arguments),
        settings: settings);
      }
    }
  }

}
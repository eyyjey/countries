import 'package:flutter/material.dart';
import 'screens/home.dart';

class RouteGenerator {
  static Route<dynamic> ?generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/home': {
        return MaterialPageRoute(builder: (_) => MyHomePage(title: '',));
      }

    }
  }

}
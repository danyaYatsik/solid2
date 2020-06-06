import 'package:flutter/material.dart';
import 'package:solid/pages/init_page.dart';
import 'package:solid/pages/result_page.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => InitPage());
        break;
      case '/result':
        return MaterialPageRoute(builder: (_) => ResultPage());
        break;
      default:
        return MaterialPageRoute(builder: (_) => Text('error'));
    }
  }
}

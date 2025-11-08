import 'package:flutter/material.dart';
import 'package:todo_list_app/pages/home_page.dart';
import 'package:todo_list_app/utils/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text("No Route Found"),
            backgroundColor: Colors.amber,
          ),
        );
    }
  }
}

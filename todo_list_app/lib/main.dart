import 'package:flutter/material.dart';
import 'package:todo_list_app/utils/routes.dart';
import 'package:todo_list_app/utils/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List App",
      initialRoute: RoutesName.homeScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

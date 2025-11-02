import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/pages/home_page.dart';
import 'package:todo_list_app/pages/login_page.dart';

import '../roles/student.dart' show Student;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool("isLogin") ?? false;
    String userType = sp.getString("userType") ?? "";

    if (isLogin) {
      if (userType == "student") {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Student()),
          );
        });
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
      }
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(
        "https://images.pexels.com/photos/34381775/pexels-photo-34381775.jpeg",
        height: double.infinity,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

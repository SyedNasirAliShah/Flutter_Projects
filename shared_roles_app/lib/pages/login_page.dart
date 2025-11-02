import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_app/pages/home_page.dart';
import 'package:todo_list_app/roles/admin.dart';
import 'package:todo_list_app/roles/student.dart';

import '../roles/teacher.dart' show Teacher;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final isLogin = false;
  final ageController = TextEditingController();

  String? dropDownValue;
  final List<String> roles = ["home", "student", "teacher", "admin"];

  @override
  void initState() {
    super.initState();
    loadUserType();
  }

  void loadUserType() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      dropDownValue = sp.getString("userType") ?? roles.first;
    });
  }

  void saveUserType(String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("userType", value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My appBar", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(height: 10),
            TextFormField(decoration: InputDecoration(hintText: "Password")),
            SizedBox(height: 10),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(hintText: "Age"),
            ),
            SizedBox(height: 15),
            DropdownButton<String>(
              value: dropDownValue,
              hint: const Text('Select Role'),
              items: roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValue = newValue!;
                });
                saveUserType(newValue!);
              },
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () async {
                String selectedRole = dropDownValue!;
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString("email", emailController.text.toString());
                sp.setString("age", ageController.text.toString());
                sp.setBool("isLogin", true);
                sp.setString("userType", selectedRole);

                if (dropDownValue == "student") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Student()),
                  );
                } else if (dropDownValue == "teacher") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Teacher()),
                  );
                } else if (dropDownValue == "admin") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Admin()),
                  );
                } else if (dropDownValue == "home") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },

              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Sin Up",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

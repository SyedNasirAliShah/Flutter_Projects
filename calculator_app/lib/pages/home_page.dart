import 'package:calculator_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = "";
  var answer = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          userInput.toString(),
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          answer.toString(),
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyButton(
                          title: "AC",
                          onPressed: () {
                            userInput = "";
                            answer = "";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "+/-",
                          onPressed: () {
                            userInput += "+/-";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "%",
                          onPressed: () {
                            userInput += "%";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "/",
                          color: Color(0xffffa00a),
                          onPressed: () {
                            userInput += "/";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(
                          title: "7",
                          onPressed: () {
                            userInput += "7";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "8",
                          onPressed: () {
                            userInput += "8";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "0",
                          onPressed: () {
                            userInput += "0";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "x",
                          color: Color(0xffffa00a),
                          onPressed: () {
                            userInput += "x";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(
                          title: "4",
                          onPressed: () {
                            userInput += "4";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "5",
                          onPressed: () {
                            userInput += "5";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "6",
                          onPressed: () {
                            userInput += "6";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "-",
                          color: Color(0xffffa00a),
                          onPressed: () {
                            userInput += "-";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(
                          title: "1",
                          onPressed: () {
                            userInput += "1";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "2",
                          onPressed: () {
                            userInput += "2";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "3",
                          onPressed: () {
                            userInput += "3";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "+",
                          color: Color(0xffffa00a),
                          onPressed: () {
                            userInput += "+";
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyButton(
                          title: "0",
                          onPressed: () {
                            userInput += "0";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: ".",
                          onPressed: () {
                            userInput += ".";
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "DEL",
                          onPressed: () {
                            if (userInput.isNotEmpty) {
                              userInput = userInput.substring(
                                0,
                                userInput.length - 1,
                              );
                            }
                            setState(() {});
                          },
                        ),
                        MyButton(
                          title: "=",
                          color: Color(0xffffa00a),
                          onPressed: () {
                            equalPressed();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void equalPressed() {
    try {
      String finalUserInput = userInput
          .replaceAll('x', '*')
          .replaceAll('%', '/100');
      Parser p = Parser();
      Expression expression = p.parse(finalUserInput);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);

      setState(() {
        answer = eval.toString();
      });
    } catch (e) {
      setState(() {
        answer = "Error";
      });
    }
  }
}

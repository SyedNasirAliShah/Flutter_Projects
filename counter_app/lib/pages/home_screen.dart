import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/counter_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;

  void _increment() => setState(() => count++);

  void _decrement() => setState(() {
    if (count > 0) count--;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: const Text(
          "Welcome to Counter App",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              "You tapped the button $count times",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterButton(icon: CupertinoIcons.add, onPressed: _increment),
                const SizedBox(width: 50),
                CounterButton(
                  icon: CupertinoIcons.minus,
                  onPressed: _decrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

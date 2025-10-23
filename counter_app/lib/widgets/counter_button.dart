import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CounterButton({super.key, required this.icon, required this.onPressed});

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onPressed();
        Feedback.forTap(context);
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: AnimatedScale(
        scale: isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.purple[200],
            shape: BoxShape.circle,
          ),
          child: Icon(widget.icon, size: 30),
        ),
      ),
    );
  }
}

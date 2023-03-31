import 'package:flutter/material.dart';

class UIButton extends StatelessWidget {
  final double width;
  final IconData icon;
  final VoidCallback onPressed;

  const UIButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3.5),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(color: Colors.black, width: 2.0)),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black45,
        ),
      ),
    );
  }
}

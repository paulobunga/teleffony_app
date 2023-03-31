import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;

  const EmptyState({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 1,
      borderPadding: const EdgeInsets.all(16),
      radius: const Radius.circular(16),
      color: Colors.grey,
      child: Container(
        constraints: const BoxConstraints(minHeight: 400),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

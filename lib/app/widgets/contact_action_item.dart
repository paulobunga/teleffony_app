import 'package:flutter/material.dart';

class ContactActionItem extends StatelessWidget {
  final String actionTitle;
  final VoidCallback onPressed;
  const ContactActionItem(
      {super.key, required this.actionTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                actionTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  return;
                },
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              )
            ],
          )),
    );
  }
}

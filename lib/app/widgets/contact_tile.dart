import 'package:flutter/material.dart';
import 'package:teleffony_app/app/models/contact_model.dart';

class ContactTile extends StatelessWidget {
  AppContact contact;
  ContactTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          contact.name!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(contact.number!),
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: Colors.lime,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                      color: Colors.black.withOpacity(0.1), width: 2.0)),
            ),
            child: const Text(
              'Contact',
            )),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onPressed: () async {
              Uri uri = Uri.parse('tel:${contact.number}');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                Get.dialog(AlertDialog(
                  title: const Text('Unable to launch'),
                  content: const Text('Sorry, unable to open specified link'),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Close'))
                  ],
                ));
              }
            },
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

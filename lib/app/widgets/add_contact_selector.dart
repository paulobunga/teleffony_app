import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';
import 'package:teleffony_app/app/widgets/contact_action_item.dart';

class AddContactSelector extends StatelessWidget {
  final HomeController c = Get.put(HomeController());
  AddContactSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: const Border.fromBorderSide(
            BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          )),
      margin: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              'Add a number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 23,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => ContactActionItem(
                    actionTitle: c.contactsToSave['form'] != null
                        ? c.contactsToSave['form']!.number!
                        : 'Write a number',
                    onPressed: () {
                      if (c.contactsToSave['form'] != null) {
                        c.getContactFromForm();
                      } else {
                        c.categoryIndex = 2;
                      }
                    },
                  )),
              Obx(() => ContactActionItem(
                    actionTitle: c.contactsToSave['phone'] != null
                        ? c.contactsToSave['phone']!.number!
                        : 'Add from phonebook',
                    onPressed: () {
                      // Oepn Phone Book
                      c.getContactFromPhone();
                    },
                  )),
              Obx(() => ContactActionItem(
                    actionTitle: c.contactsToSave['social'] != null
                        ? c.contactsToSave['social']!.number!
                        : 'Add from social media',
                    onPressed: () {
                      if (c.contactsToSave['social'] != null) {
                        c.getContactFromSocial();
                      } else {
                        c.categoryIndex = 3;
                      }
                    },
                  )),
            ],
          ),
          MaterialButton(
            onPressed: () {
              c.confirmSaveNumbers();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          )
        ],
      ),
    );
  }
}

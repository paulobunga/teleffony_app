import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';

class AddContactForm extends StatelessWidget {
  final HomeController c = Get.put(HomeController());
  AddContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width * .75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: const Border.fromBorderSide(
            BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          )),
      margin: const EdgeInsets.fromLTRB(10, 5, 20, 5),
      alignment: Alignment.bottomCenter,
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: c.addNameController,
              decoration: InputDecoration(
                hintText: 'Name',
                prefixIcon: const Icon(Icons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: c.addPhoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () {
                c.getContactFromForm();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(
                    color: Colors.black26,
                    width: 1.5,
                  )),
              child: const Text('Save Number'),
            )
          ],
        ),
      ),
    );
  }
}

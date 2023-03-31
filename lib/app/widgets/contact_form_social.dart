import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';

class AddContactFormSocial extends StatelessWidget {
  HomeController c = Get.put(HomeController());
  AddContactFormSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width * .75,
      height: Get.height * 0.90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: const Border.fromBorderSide(
            BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          )),
      margin: const EdgeInsets.fromLTRB(10, 5, 20, 5),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: c.addNameController,
                decoration: InputDecoration(
                  labelText: 'Social Media',
                  hintText: 'e.g Facebook or Linkedin',
                  prefixIcon: const Icon(Icons.navigation),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: c.addSocialLink,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Link or Handle',
                  hintText:
                      'e.g http://linkedin.com/in/yourcompany or @company',
                  prefixIcon: const Icon(Icons.link),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  c.getContactFromSocial();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(
                      color: Colors.black26,
                      width: 1.5,
                    )),
                child: const Text('Save Social Link'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';
import 'package:teleffony_app/app/widgets/contact_tile.dart';

class ContactList extends StatelessWidget {
  final HomeController c = Get.put(HomeController());

  ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Obx(() => Column(
            children: [
              c.contacts.isNotEmpty
                  ? Expanded(child: Obx(
                      () {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              var contact = c.contacts.elementAt(index);
                              return Obx(() => Container(
                                    child: c.enableDelete.value
                                        ? CheckboxListTile(
                                            title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(contact.name!),
                                                  Text(contact.number!)
                                                ]),
                                            value: contact.marked,
                                            onChanged: (value) {
                                              contact.marked = value ?? false;
                                              c.contacts[index] = contact;
                                              c.markForDelete(contact);
                                            },
                                          )
                                        : ListTile(
                                            title:
                                                ContactTile(contact: contact),
                                          ),
                                  ));
                            },
                            separatorBuilder: (contex, index) {
                              return const Divider();
                            },
                            itemCount: c.contacts.length);
                      },
                    ))
                  : Expanded(
                      child: Container(
                        width: Get.width,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('No Contacts',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey.shade300)),
                            Text(
                              'Contacts you add will appear here',
                              style: TextStyle(color: Colors.grey.shade300),
                            ),
                          ],
                        ),
                      ),
                    ),
              Obx(() => c.contacts.isEmpty
                  ? const SizedBox.shrink()
                  : MaterialButton(
                      onPressed: () {
                        c.deleteContacts();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          )),
                      child: Obx(() => Text(
                          c.enableDelete.value ? 'Confirm Delete' : 'Delete')),
                    ))
            ],
          )),
    );
  }
}

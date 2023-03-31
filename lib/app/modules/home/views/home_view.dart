import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/models/category_model.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';
import 'package:teleffony_app/app/widgets/add_category_section.dart';
import 'package:teleffony_app/app/widgets/add_contact_selector.dart';
import 'package:teleffony_app/app/widgets/category_dropdown_section.dart';
import 'package:teleffony_app/app/widgets/contact_form_modal.dart';
import 'package:teleffony_app/app/widgets/contact_form_social.dart';
import 'package:teleffony_app/app/widgets/contact_list.dart';
import 'package:teleffony_app/app/widgets/empty_state.dart';
import 'package:teleffony_app/app/widgets/search_input_section.dart';
import 'package:teleffony_app/app/widgets/ui_card.dart';

class HomeView extends GetView<HomeController> {
  final HomeController c = Get.put(HomeController());

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teleffony',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          AddCategorySection(),
          SearchInputSection(),
          CategoryDropdownSection(),
          Expanded(
            child: Obx(
              () => c.selectedCategories.isEmpty
                  ? const EmptyState(
                      title: 'No Categories',
                      message: 'Categories you add will appear here',
                    )
                  : Expanded(
                      child: Container(
                        color: Colors.grey.shade100,
                        child: Obx(
                          () => ListView.builder(
                            itemBuilder: (context, index) {
                              return UICard(
                                image: c.selectedCategories
                                    .elementAt(index)
                                    .image!,
                                name:
                                    c.selectedCategories.elementAt(index).name!,
                                onPressed: () {
                                  Category category =
                                      c.selectedCategories.elementAt(index);

                                  c.openCategoryDetails(category);
                                },
                              );
                            },
                            itemCount: c.selectedCategories.length,
                          ),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryDetailsModal extends StatelessWidget {
  final Category category;
  final HomeController c = Get.put(HomeController());
  CategoryDetailsModal({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: Get.height / 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: UICard(
                            image: category.image!,
                            name: category.name!,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            c.closeDetailsView();
                          },
                          icon: const Icon(
                            Icons.close,
                          ))
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Spacer(),
                    Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            c.categoryIndex = 1;
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          child: const Text(
                            '+0',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 28,
                            ),
                          ),
                        ),
                        const Text(
                          'Add Number',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() => IndexedStack(
                      index: c.categoryIndex,
                      alignment: Alignment.center,
                      children: [
                        ContactList(),
                        AddContactSelector(),
                        AddContactForm(),
                        AddContactFormSocial()
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

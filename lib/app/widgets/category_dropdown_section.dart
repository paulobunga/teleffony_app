import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';
import 'package:teleffony_app/app/widgets/add_category_modal.dart';
import 'package:teleffony_app/app/widgets/ui_button.dart';
import 'package:teleffony_app/app/widgets/ui_card.dart';

class CategoryDropdownSection extends StatelessWidget {
  final HomeController c = Get.put(HomeController());

  CategoryDropdownSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: c.categorySelectorShown ? Get.width * 0.25 : 0,
          color: Colors.grey.shade50,
          child: Row(
            children: [
              Container(
                color: Colors.grey.shade50,
                width: Get.width * .75 - 20,
                child: c.categories.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Categories',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueGrey.shade300,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Click Create Button to add new Categories',
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          )
                        ],
                      )
                    : CupertinoScrollbar(
                        controller: c.scrollController,
                        child: ListView.builder(
                          controller: c.scrollController,
                          itemExtent: Get.width * 0.25,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return UICard(
                              image: c.categories.elementAt(index).image ?? '',
                              name: c.categories.elementAt(index).name ?? '',
                              onPressed: () {
                                c.addToSelectedCategories(
                                    c.categories.elementAt(index));
                              },
                            );
                          },
                          itemCount: c.categories.length,
                        ),
                      ),
              ),
              SizedBox(
                width: Get.width * 0.25,
                height: Get.width * 0.25,
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.25),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UIButton(
                        onPressed: () {
                          Get.dialog(Dialog(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            alignment: Alignment.center,
                            child: AddCategoryModal(),
                          ));
                        },
                        icon: Icons.add,
                        width: 60,
                      ),
                      const Text('Create')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';
import 'package:teleffony_app/app/widgets/ui_button.dart';

class AddCategorySection extends StatelessWidget {
  final HomeController c = Get.put(HomeController());
  AddCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: MediaQuery.of(context).size.width / 6,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 8.0,
              ),
            ),
          ),
          child: Column(
            children: [
              UIButton(
                icon: Icons.add,
                onPressed: () {
                  c.categorySelectorShown = !c.categorySelectorShown;
                },
              ),
              const Text(
                'Add Category',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

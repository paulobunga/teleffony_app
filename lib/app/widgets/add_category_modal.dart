import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/models/category_model.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';
import 'package:teleffony_app/app/widgets/ui_button.dart';
import 'package:uuid/uuid.dart';

class AddCategoryModal extends StatelessWidget {
  final HomeController c = Get.put(HomeController());

  AddCategoryModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          Obx(
            () => Expanded(
              child: c.imageFile.value != null
                  ? SizedBox(
                      width: Get.width * 0.85,
                      child: Image.file(
                        c.imageFile.value!,
                        fit: BoxFit.contain,
                      ),
                    )
                  : SizedBox(
                      height: double.infinity,
                      child: UIButton(
                        icon: Icons.add_a_photo_rounded,
                        onPressed: c.selectPicture,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: c.nameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                isDense: true,
                hintText: 'Category Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(
                25,
              ),
            ),
            minWidth: MediaQuery.of(context).size.width / 3,
            onPressed: () {
              c.setCategory(
                Category(
                    id: const Uuid().v4(),
                    name: c.nameController.text,
                    image: c.imageFile.value!.path),
              );

              c.nameController.clear();
              c.imageFile.value = null;
              Get.back();
            },
            child: const Text('Add Category'),
          )
        ],
      ),
    );
  }
}

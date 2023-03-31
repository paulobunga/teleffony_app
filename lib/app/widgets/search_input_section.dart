import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teleffony_app/app/modules/home/controllers/home_controller.dart';

class SearchInputSection extends StatelessWidget {
  HomeController c = Get.put(HomeController());

  SearchInputSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width,
            height: 35,
            child: TextField(
              onChanged: (searchTerm) => c.filterResults(searchTerm),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Colors.black,
                ),
                labelText: 'Start search',
                filled: false,
                isDense: true,
                fillColor: Colors.grey.shade100,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

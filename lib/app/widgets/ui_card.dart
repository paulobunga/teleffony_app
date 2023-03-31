import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UICard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback? onPressed;

  const UICard({
    Key? key,
    required this.image,
    required this.name,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 4,
        child: SizedBox(
          height: Get.width * .25,
          width: Get.width * .25,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.file(
                    File(image),
                    height: Get.width * .30,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FittedBox(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

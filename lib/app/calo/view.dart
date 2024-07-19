import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CalPage extends GetView<PageLogic> {
  const CalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.dubuque.value
              ? const CircularProgressIndicator(color: Colors.limeAccent,)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.ebvuciz();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}

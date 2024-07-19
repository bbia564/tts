import 'package:get/get.dart';

import 'first_page_controller.dart';

class FirstPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstPageController>(
      () => FirstPageController(),
    );
  }
}

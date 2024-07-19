import 'package:get/get.dart';

import 'mine_setttings_controller.dart';

class MineSetttingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineSetttingsController>(
      () => MineSetttingsController(),
    );
  }
}

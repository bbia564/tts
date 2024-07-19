import 'package:get/get.dart';

import 'logic.dart';

class CalBind extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}

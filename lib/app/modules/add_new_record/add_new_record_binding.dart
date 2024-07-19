import 'package:get/get.dart';

import 'add_new_record_controller.dart';

class AddNewRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewRecordController>(
      () => AddNewRecordController(),
    );
  }
}

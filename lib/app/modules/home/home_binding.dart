import 'package:calorie_manager/app/modules/first_page/first_page_controller.dart';
import 'package:calorie_manager/app/modules/history_page/history_page_controller.dart';
import 'package:calorie_manager/app/modules/mine_setttings/mine_setttings_controller.dart';
import 'package:calorie_manager/app/modules/tools/cm_database.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {

    CMDBUtil().init();
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
     Get.lazyPut<FirstPageController>(
      () => FirstPageController(),
    );
     Get.lazyPut<HistoryPageController>(
      () => HistoryPageController(),
    );
     Get.lazyPut<MineSetttingsController>(
      () => MineSetttingsController(),
    );
  }
}

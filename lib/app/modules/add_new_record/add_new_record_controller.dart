import 'package:bot_toast/bot_toast.dart';
import 'package:calorie_manager/app/assets/assets.dart';
import 'package:calorie_manager/app/modules/first_page/first_page_controller.dart';
import 'package:calorie_manager/app/modules/tools/app_util.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:calorie_manager/app/modules/tools/cm_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewRecordController extends GetxController {
  final inpuController = TextEditingController();

  final isIntake = false.obs;

  final intakeSelcte = 0.obs;

  final consumeSelcte = 0.obs;

  final intakingIcons = [
    Assets.rice,
    Assets.noodles,
    Assets.friedchicken,
    Assets.hamburger,
  ];

  final intakingTitles = ["Rice", "Noodles", "Chicken", "Hamburger"];

  final consumeIcons = [
    Assets.runing,
    Assets.fitness,
    Assets.climb,
  ];

  final consumeTitles = [
    "Runing",
    "Fitness",
    "Climbing",
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    inpuController.dispose();
    super.onClose();
  }

  void addRecord() async {
    if (inpuController.text.isEmpty) {
      BotToast.showText(text: "Please input kcal");
      return;
    }

    final newModel = CMIntakemodel();
    final today = DateTime.now();
    newModel.isIntake = isIntake.value;
    newModel.timestamp = today.millisecondsSinceEpoch;
    newModel.dateStr = PMAppUtil.formatDateWithoutHour(dateTime: today);
    if (isIntake.isTrue) {
      newModel.name = intakingTitles[intakeSelcte.value];
      newModel.iconName = intakingIcons[intakeSelcte.value];
    } else {
      newModel.name = consumeTitles[consumeSelcte.value];
      newModel.iconName = consumeIcons[consumeSelcte.value];
    }

    newModel.kcal = int.parse(inpuController.text);

    await CMDBUtil().insertRecord(newModel);

    if (Get.isRegistered<FirstPageController>()) {
      Get.find<FirstPageController>().reloadDatas();
    }
    Get.back();
  }
}

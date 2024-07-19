import 'package:bot_toast/bot_toast.dart';
import 'package:calorie_manager/app/modules/first_page/first_page_controller.dart';
import 'package:calorie_manager/app/modules/tools/cm_database.dart';
import 'package:calorie_manager/app/modules/tools/cmdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineSetttingsController extends GetxController {
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
    super.onClose();
  }

  void showclearAleart() {
    Get.dialog(Center(
      child: CMDialog(
        title: "Tips",
        contentStr: "Are you sure to clear all records",
        okAction: cleanDatas,
      ),
    ));
  }

  void showVersionAleart() {
    Get.dialog(Center(
      child: CMDialog(
        title: "Version",
        contentStr: "V1.0.0",
        okAction: Get.back,
      ),
    ));
  }

  void cleanDatas() async {
    await CMDBUtil().clean();
    if (Get.isRegistered<FirstPageController>()) {
      Get.find<FirstPageController>().reloadDatas();
    }
    BotToast.showText(text: "Clear Success");
  }
}

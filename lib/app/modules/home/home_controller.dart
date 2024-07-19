import 'package:calorie_manager/app/modules/first_page/first_page_view.dart';
import 'package:calorie_manager/app/modules/history_page/history_page_view.dart';
import 'package:calorie_manager/app/modules/mine_setttings/mine_setttings_view.dart';
import 'package:calorie_manager/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  List<Widget> pageList = [
    const FirstPageView(),
    const HistoryPageView(),
    const MineSetttingsView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // PMDBTool().init();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeCurrentPageIndex(int index) {
    currentIndex.value = index;
  }

  void showAddView() {
   
  }
}


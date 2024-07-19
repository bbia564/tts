import 'package:calorie_manager/app/assets/assets.dart';
import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              controller.currentIndex.value = value;
            },
            children: controller.pageList,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: CMColorTools.cmColor("#1E2227"),
            currentIndex: controller.currentIndex.value,
            fixedColor: Colors.white,
            unselectedItemColor: CMColorTools.cmColor("#9D9D9D"),
            unselectedLabelStyle: TextStyle(
                color: CMColorTools.cmColor("#9D9D9D"),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
            selectedLabelStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
            onTap: (value) {
              controller.currentIndex.value = value;
              controller.pageController.jumpToPage(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: _tbTbarItem(Assets.homeNormal),
                  activeIcon: _tbTbarItem(Assets.homeSelected),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: _tbTbarItem(Assets.recordNormal),
                  activeIcon: _tbTbarItem(Assets.recordSelected),
                  label: "History"),
              BottomNavigationBarItem(
                label: "Settings",
                icon: _tbTbarItem(Assets.mineNormal),
                activeIcon: _tbTbarItem(Assets.mineSelected),
              )
            ],
          ),
        ));
  }

  Widget _tbTbarItem(String name) {
    return Image.asset(
      name,
      height: 22.h,
      width: 22.h,
      fit: BoxFit.cover,
    );
  }
}

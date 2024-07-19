import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:calorie_manager/app/modules/tools/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'mine_setttings_controller.dart';

class MineSetttingsView extends GetView<MineSetttingsController> {
  const MineSetttingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kMinInteractiveDimension.verticalSpace,
                    CMText(" Settings", fontSize: 24, textColor: Colors.white),
                    14.verticalSpace,
                    InkWell(
                      onTap: controller.showclearAleart,
                      child: CMContainer(
                        radius: 10.w,
                        height: 54.h,
                        color: CMColorTools.cmColor("#1E2227"),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 16.w),
                        child: CMText("Clear",
                            fontWeight: FontWeight.w400,
                            textColor: Colors.white),
                      ),
                    ),
                    10.verticalSpace,
                    InkWell(
                      onTap: controller.showVersionAleart,
                      child: CMContainer(
                        radius: 10.w,
                        height: 54.h,
                        color: CMColorTools.cmColor("#1E2227"),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            CMText("Version",
                                fontWeight: FontWeight.w400,
                                textColor: Colors.white),
                            const Spacer(),
                            CMText("V1.0.0",
                                fontWeight: FontWeight.w400,
                                textColor: CMColorTools.cmColor("#9D9D9D")),
                          ],
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}

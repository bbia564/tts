import 'package:calorie_manager/app/assets/assets.dart';
import 'package:calorie_manager/app/modules/first_page/record_cell.dart';
import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:calorie_manager/app/modules/tools/componets.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'first_page_controller.dart';

class FirstPageView extends GetView<FirstPageController> {
  const FirstPageView({super.key});
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
            30.verticalSpace,
            InkWell(
              onTap: controller.toAddNew,
              child: CMContainer(
                  color: CMColorTools.cmYellow,
                  radius: 36.w,
                  height: 72.w,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.addRecordIcon,
                        width: 19.w,
                        height: 19.w,
                      ),
                      5.horizontalSpace,
                      CMText("Record", fontSize: 24)
                    ],
                  )),
            ),
            20.verticalSpace,
            Obx(() => CMText("Consumption ${controller.consumeTotal.value} Kcal",
                fontSize: 24, textColor: Colors.white)),
            15.verticalSpace,
            Obx(
              () => controller.consumeModels.isEmpty
                  ? CMContainer(
                      color: CMColorTools.cmColor("#1E2227"),
                      radius: 10.w,
                      height: 72.w,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CMText("No data today",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textColor: CMColorTools.cmColor("#9D9D9D")))
                  : _listView(controller.consumeModels.value),
            ),
            20.verticalSpace,
            Obx(() => CMText("Intake ${controller.inkcalTotal.value} Kcal",
                fontSize: 24, textColor: Colors.white)),
            15.verticalSpace,
            Obx(() => controller.intakeModels.isEmpty
                ? CMContainer(
                    color: CMColorTools.cmColor("#27251E"),
                    radius: 10.w,
                    height: 72.w,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CMText("No data today",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textColor: CMColorTools.cmColor("#9D9D9D")))
                : _listView(controller.intakeModels.value)),
          ],
        ),
      )),
    );
  }

  Widget _listView(List<CMIntakemodel> models) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: models.length,
      physics: const NeverScrollableScrollPhysics(
          parent: AlwaysScrollableScrollPhysics()),
      itemBuilder: (context, index) {
        final model = models[index];
        return RecordCell(model: model);
      },
    );
  }
}


import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:calorie_manager/app/modules/tools/componets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'add_new_record_controller.dart';

class AddNewRecordView extends GetView<AddNewRecordController> {
  const AddNewRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget intakeWidget = Obx(() {
      final index = controller.intakeSelcte.value;
      final list = <Widget>[];

      for (var i = 0; i < controller.intakingIcons.length; i++) {
        final title = controller.intakingTitles[i];
        final icon = controller.intakingIcons[i];
        list.add(_inTakeItem(
            title: title, iconName: icon, isSelected: index == i, index: i));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      );
    });

    Widget consumWidget = Obx(() {
      final index = controller.consumeSelcte.value;
      final list = <Widget>[];

      for (var i = 0; i < controller.consumeIcons.length; i++) {
        final title = controller.consumeTitles[i];
        final icon = controller.consumeIcons[i];
        list.add(_consumItem(
            title: title, iconName: icon, isSelected: index == i, index: i));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: CMText("Add", textColor: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _changeValueView(),
            20.verticalSpace,
            CMContainer(
                color: CMColorTools.cmColor("#1E2227"),
                padding: EdgeInsets.all(16.w),
                radius: 10.w,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    12.verticalSpace,
                    Obx(() => controller.isIntake.isTrue
                        ? intakeWidget
                        : consumWidget),
                    20.verticalSpace,
                    pmDivider(),
                    12.verticalSpace,
                    CMText("  consume Kcal",
                        textColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    10.verticalSpace,
                    _inputView(),
                    25.verticalSpace,
                    InkWell(
                      onTap: controller.addRecord,
                      child: CMContainer(
                          height: 50.w,
                          radius: 25.w,
                          width: double.infinity,
                          alignment: Alignment.center,
                          color: CMColorTools.cmColor("#E1F062"),
                          child: CMText("Record")),
                    ),
                    20.verticalSpace
                  ],
                ))
          ],
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////
  ///
  ///
  Widget _inputView() {
    return CMContainer(
        radius: 10.w,
        height: 54.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        color: CMColorTools.cmColor("#2B2F34"),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: TextField(
                  controller: controller.inpuController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, 
                      LengthLimitingTextInputFormatter(4),
                    ],
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                        hintText: 'input number',
                        hintStyle: TextStyle(
                            color: CMColorTools.cmColor('#9D9D9D'),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal)),
                    onChanged: (value) {})),
            10.horizontalSpace,
            CMText("Kcal", fontSize: 14, textColor: Colors.white)
          ],
        ));
  }

  Widget _changeValueView() {
    return Obx(() => SizedBox(
          height: 48.w,
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      controller.isIntake.value = false;
                    },
                    child: CMContainer(
                      radius: 24.w,
                      height: 48.w,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: controller.isIntake.isTrue
                          ? CMColorTools.cmColor("#1E2227")
                          : Colors.white,
                      child: CMText("Consume",
                          fontSize: 18,
                          textColor: controller.isIntake.isTrue
                              ? Colors.white
                              : CMColorTools.cmColor("#0D1011")),
                    ),
                  )),
              10.horizontalSpace,
              Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      controller.isIntake.value = true;
                    },
                    child: CMContainer(
                      radius: 24.w,
                      height: 48.w,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: controller.isIntake.isFalse
                          ? CMColorTools.cmColor("#1E2227")
                          : Colors.white,
                      child: CMText("Intake",
                          fontSize: 18,
                          textColor: controller.isIntake.isFalse
                              ? Colors.white
                              : CMColorTools.cmColor("#0D1011")),
                    ),
                  )),
            ],
          ),
        ));
  }

  ///

  Widget _inTakeItem(
      {required String title,
      required String iconName,
      required bool isSelected,
      required int index}) {
    return InkWell(
      onTap: () {
        controller.intakeSelcte.value = index;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CMContainer(
              radius: 22.w,
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              color: isSelected
                  ? CMColorTools.cmColor("#FFCB3C")
                  : CMColorTools.cmColor("#78652F"),
              child: Image.asset(
                iconName,
                height: 22.w,
                width: 22.w,
                fit: BoxFit.cover,
              )),
          12.verticalSpace,
          CMText(title,
              textColor:
                  isSelected ? Colors.white : CMColorTools.cmColor("#999999"),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400)
        ],
      ),
    );
  }

  Widget _consumItem(
      {required String title,
      required String iconName,
      required bool isSelected,
      required int index}) {
    return InkWell(
      onTap: () {
        controller.consumeSelcte.value = index;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CMContainer(
              radius: 22.w,
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              color: isSelected
                  ? CMColorTools.cmColor("#E1F062")
                  : CMColorTools.cmColor("#6D743E"),
              child: Image.asset(
                iconName,
                height: 22.w,
                width: 22.w,
                fit: BoxFit.cover,
              )),
          12.verticalSpace,
          CMText(title,
              textColor:
                  isSelected ? Colors.white : CMColorTools.cmColor("#999999"),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400)
        ],
      ),
    );
  }
}

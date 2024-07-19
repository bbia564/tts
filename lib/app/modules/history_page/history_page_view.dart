import 'package:calorie_manager/app/assets/assets.dart';
import 'package:calorie_manager/app/modules/first_page/record_cell.dart';
import 'package:calorie_manager/app/modules/tools/app_util.dart';
import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:calorie_manager/app/modules/tools/componets.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'history_page_controller.dart';

class HistoryPageView extends GetView<HistoryPageController> {
  const HistoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<HistoryPageController>(init: HistoryPageController(),builder: (_) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CMContainer(
                      color: CMColorTools.cmColor("#0D1011"),
                      child: TableCalendar(
                        // locale: 'zh_CN',
                        firstDay: DateTime(2024, 6, 1),
                        lastDay: DateTime(2025, 6, 30),
                        focusedDay: DateTime.now(),
                        onDaySelected: (selectedDay, focusedDay) {
                          controller.reloadDatas(selectedDay);
                        },
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: CMColorTools.cmColor("#E1F062"),
                          ),
                          formatButtonVisible: false,
                          leftChevronIcon: Image.asset(
                            Assets.aroowLeft,
                            height: 16.w,
                            width: 16.w,
                          ),
                          rightChevronIcon: Image.asset(
                            Assets.arrowRight,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.white),
                          weekendStyle: TextStyle(color: Colors.white),
                        ),
                        calendarStyle: const CalendarStyle(
                          defaultTextStyle: TextStyle(color: Colors.white),
                          weekendTextStyle: TextStyle(color: Colors.white),
                        ),
                        currentDay: controller.currentTime,
                        onPageChanged: (focusedDay) {
                          controller.reloadDatas(focusedDay);
                          final dateStr = "${focusedDay.year}-${PMAppUtil
                              .numFormat(focusedDay.month)}";
                        },
                      )),
                  20.verticalSpace,
                  Obx(() =>
                      CMText(
                          "Total consume ${controller.consumeTotal.value} Kcal",
                          fontSize: 24, textColor: Colors.white)),
                  15.verticalSpace,
                  Obx(
                        () =>
                    controller.consumeModels.isEmpty
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
                  Obx(() =>
                      CMText(
                          "Total intake ${controller.inkcalTotal.value} Kcal",
                          fontSize: 24, textColor: Colors.white)),
                  15.verticalSpace,
                  Obx(() =>
                  controller.intakeModels.isEmpty
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
            );
          })),
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

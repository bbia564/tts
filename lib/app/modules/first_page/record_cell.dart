import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:calorie_manager/app/modules/tools/componets.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecordCell extends StatelessWidget {
  final CMIntakemodel model;
  const RecordCell({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(model.timestamp ?? 0);
    return CMContainer(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 72.h,
        radius: 10.w,
        width: double.infinity,
        color: model.isIntake == true
            ? CMColorTools.cmColor("#27251E")
            : CMColorTools.cmColor("#1E2227"),
        child: Row(
          children: [
            CMContainer(
                radius: 22.w,
                width: 44.w,
                height: 44.w,
                alignment: Alignment.center,
                color: model.isIntake == true
                    ? CMColorTools.cmColor("#E1F062")
                    : CMColorTools.cmColor("#FFCB3C"),
                child: Image.asset(
                  model.iconName ?? "",
                  height: 22.w,
                  width: 22.w,
                  fit: BoxFit.cover,
                )),
            5.horizontalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CMText(model.name ?? "-",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.white),
                2.verticalSpace,
                CMText("${date.hour}:${date.minute}",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: CMColorTools.cmColor("#999999")),
              ],
            ),
            const Spacer(),
            CMText(model.isIntake == true ? "Intake:" : "Consume:",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: Colors.white),
            CMText("${model.kcal}",
                fontSize: 14,
                textColor: model.isIntake == true
                    ? CMColorTools.cmColor("#E1F062")
                    : CMColorTools.cmColor("#FFCB3C")),
          ],
        ));
  }
}

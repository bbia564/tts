import 'package:bot_toast/bot_toast.dart';
import 'package:calorie_manager/app/modules/tools/app_util.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:calorie_manager/app/modules/tools/cm_database.dart';
import 'package:calorie_manager/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HistoryPageController extends GetxController {
  final inkcalTotal = 0.obs;
  final consumeTotal = 0.obs;

  DateTime currentTime = DateTime.now();

  final intakeModels = <CMIntakemodel>[].obs;
  final consumeModels = <CMIntakemodel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    reloadDatas(DateTime.now());
  }

  @override
  void onClose() {
    super.onClose();
  }

  void clearDatas() {
    inkcalTotal.value = 0;
    consumeTotal.value = 0;

    intakeModels.value = [];
    consumeModels.value = [];
  }

  void reloadDatas(DateTime dateTime) async {
    currentTime = dateTime;
    update();
    final cancel = BotToast.showLoading();

    final allDateModel = await CMDBUtil().getAllDates();

    if (allDateModel.isEmpty) {
      clearDatas();
      cancel();
      return;
    }

    final todayMonthStr =
        "${dateTime.year}-${PMAppUtil.numFormat(dateTime.month)}";
    var inkcal = 0;
    var outkcal = 0;

    final allIntakeList = <CMIntakemodel>[];
    final allConsumeList = <CMIntakemodel>[];

    var hasDate = false;
    for (var dateModel in allDateModel) {
      if (dateModel.date!.contains(todayMonthStr)) {
        hasDate = true;
        final list =
            await CMDBUtil().getAllIntakeData(dateID: dateModel.id ?? 0);
        allIntakeList.addAll(list);

        for (var element in list) {
          inkcal += (element.kcal ?? 0);
        }

        final conList =
            await CMDBUtil().getAllConsumData(dateID: dateModel.id ?? 0);
        allConsumeList.addAll(conList);
        for (var element in conList) {
          outkcal += (element.kcal ?? 0);
        }
      }
    }

    if (hasDate) {
      inkcalTotal.value = inkcal;
      consumeTotal.value = outkcal;

      intakeModels.value = allIntakeList;
      consumeModels.value = allConsumeList;
    } else {
      clearDatas();
    }

    cancel();
  }
}

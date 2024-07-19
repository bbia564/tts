import 'package:bot_toast/bot_toast.dart';
import 'package:calorie_manager/app/modules/tools/intakemodel.dart';
import 'package:calorie_manager/app/modules/tools/cm_database.dart';
import 'package:calorie_manager/app/routes/app_pages.dart';
import 'package:get/get.dart';

class FirstPageController extends GetxController {
  final inkcalTotal = 0.obs;
  final consumeTotal = 0.obs;

  final intakeModels = <CMIntakemodel>[].obs;
  final consumeModels = <CMIntakemodel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    reloadDatas();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toAddNew() {
    Get.toNamed(Routes.ADD_NEW_RECORD, arguments: {});
  }

  void reloadDatas() async {
    final cancel = BotToast.showLoading();

    final todayModel = await CMDBUtil().getToday();

    if (todayModel == null) {
      cancel();
      return;
    }

    var inkcal = 0;
    var outkcal = 0;
    final list = await CMDBUtil().getAllIntakeData(dateID: todayModel.id ?? 0);

    for (var element in list) {
      inkcal += (element.kcal ?? 0);
    }

    final conList =
        await CMDBUtil().getAllConsumData(dateID: todayModel.id ?? 0);

    for (var element in conList) {
      outkcal += (element.kcal ?? 0);
    }

    inkcalTotal.value = inkcal;
    consumeTotal.value = outkcal;

    intakeModels.value = list;
    consumeModels.value = conList;

    cancel();
  }
}

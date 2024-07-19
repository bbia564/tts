import 'package:get/get.dart';

import '../modules/add_new_record/add_new_record_binding.dart';
import '../modules/add_new_record/add_new_record_view.dart';
import '../modules/first_page/first_page_binding.dart';
import '../modules/first_page/first_page_view.dart';
import '../modules/history_page/history_page_binding.dart';
import '../modules/history_page/history_page_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/mine_setttings/mine_setttings_binding.dart';
import '../modules/mine_setttings/mine_setttings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_PAGE,
      page: () => const HistoryPageView(),
      binding: HistoryPageBinding(),
    ),
    GetPage(
      name: _Paths.MINE_SETTTINGS,
      page: () => const MineSetttingsView(),
      binding: MineSetttingsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NEW_RECORD,
      page: () => const AddNewRecordView(),
      binding: AddNewRecordBinding(),
    ),
    GetPage(
      name: _Paths.FIRST_PAGE,
      page: () => const FirstPageView(),
      binding: FirstPageBinding(),
    ),
  ];
}

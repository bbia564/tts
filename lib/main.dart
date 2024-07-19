import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:calorie_manager/app/calo/binding.dart';
import 'package:calorie_manager/app/modules/rie.dart';
import 'package:calorie_manager/app/modules/tools/app_util.dart';
import 'package:calorie_manager/app/modules/tools/color_tool.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'app/calo/view.dart';
import 'app/modules/add_new_record/add_new_record_binding.dart';
import 'app/modules/add_new_record/add_new_record_view.dart';
import 'app/modules/first_page/first_page_binding.dart';
import 'app/modules/first_page/first_page_view.dart';
import 'app/modules/history_page/history_page_binding.dart';
import 'app/modules/history_page/history_page_view.dart';
import 'app/modules/home/home_binding.dart';
import 'app/modules/home/home_view.dart';
import 'app/modules/mine_setttings/mine_setttings_binding.dart';
import 'app/modules/mine_setttings/mine_setttings_view.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(_initApp());
}

Widget ceInitGetMaterialApp({
  Widget Function(BuildContext, Widget?)? builder,
}) {
  return GetMaterialApp(
    darkTheme: ThemeData.dark(),
    useInheritedMediaQuery: true,
    themeMode: ThemeMode.light,
    fallbackLocale: const Locale("zh", "CN"),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages:Pages,
    defaultTransition: Transition.rightToLeft,
    theme: ThemeData(
      scaffoldBackgroundColor: CMColorTools.cmColor("#0D1011"),
      indicatorColor: Colors.grey,
      brightness: Brightness.light,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: CMColorTools.cmColor("#0D1011"),
            statusBarColor: CMColorTools.cmColor("#0D1011")),
        backgroundColor: CMColorTools.cmColor("#0D1011"),
        scrolledUnderElevation: 0.0
      ),
      bottomAppBarTheme:
          BottomAppBarTheme(color: CMColorTools.cmColor("#1E2227")),
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   backgroundColor: CMColorTools.cmColor("#1E2227"),
      // ),
    ),
    builder: builder,
    navigatorObservers: [BotToastNavigatorObserver()],
    supportedLocales: const [
      Locale('zh', 'CN'),
      Locale('en', 'US'),
    ],
    localizationsDelegates: const [
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
  );
}

_initApp() {
  if (!kIsWeb && Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  _setBotToast();

  Widget body = ceInitGetMaterialApp(
    builder: (context, child) {
      final botToastBuilder = BotToastInit();

      return ScreenUtilInit(
        designSize: const Size(375, 812),
        useInheritedMediaQuery: true,
        builder: (p0, p1) {
          Widget body = GestureDetector(
            onTap: () {
              PMAppUtil.keyboardDis(context);
            },
            child: child,
          );
          body = botToastBuilder(context, body);
          return body;
        },
      );
    },
  );
  return body;
}

void _setBotToast() {
  BotToast.defaultOption.notification.animationDuration =
      const Duration(seconds: 2);
}
List<GetPage<dynamic>> Pages = [
  GetPage(name: '/', page: () => const CalPage(),binding: CalBind()),
  GetPage(name: '/rie', page: () => const RiePage()),
  GetPage(name: '/home', page: () => const HomeView(),binding: HomeBinding()),
  GetPage(name: '/history-page', page: () => const HistoryPageView(),binding: HistoryPageBinding()),
  GetPage(name: '/mine-setttings', page: () => const MineSetttingsView(),binding: MineSetttingsBinding()),
  GetPage(name: '/add-new-record', page: () => const AddNewRecordView(),binding: AddNewRecordBinding()),
  GetPage(name: '/first-page', page: () => const FirstPageView(),binding: FirstPageBinding()),
];
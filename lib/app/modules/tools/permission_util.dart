import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  /// 检测是否有权限
  /// [permissionList] 权限申请列表
  static Future<bool> checkPermission(List<Permission> permissionList) async {
    ///一个新待申请权限列表
    List<Permission> newPermissionList = [];

    ///遍历当前权限申请列表
    for (Permission permission in permissionList) {
      PermissionStatus status = await permission.status;

      ///如果不是允许状态就添加到新的申请列表中
      if (!status.isGranted || !status.isLimited) {
        newPermissionList.add(permission);
      }
    }

    ///如果需要重新申请的列表不是空的
    if (newPermissionList.isNotEmpty) {
      if (Platform.isAndroid) {
        _showTopInstructionsDialog(newPermissionList);
      }
      PermissionStatus permissionStatus =
          await _requestPermission(newPermissionList);
      switch (permissionStatus) {
        ///拒绝状态
        case PermissionStatus.denied:
          _showFailedDialog(newPermissionList, isPermanentlyDenied: true);
          return false;

        ///允许状态
        case PermissionStatus.granted:
        case PermissionStatus.limited:
        case PermissionStatus.provisional:
          BotToast.cleanAll();
          return true;

        /// 永久拒绝  活动限制
        case PermissionStatus.restricted:
        case PermissionStatus.permanentlyDenied:
          _showFailedDialog(newPermissionList, isPermanentlyDenied: true);
          break;
      }
    } else {
      return true;
    }
    return false;
  }

  /// 获取新列表中的权限 如果有一项不合格就返回false
  static Future<PermissionStatus> _requestPermission(
      List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted || !value.isLimited) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }

  static Future<bool> checkLocationAlways() async {
    ///获取前置状态
    /// Android没有这一步 ios会先访问这个再访问其他的
    PermissionStatus status = PermissionStatus.granted;
    status = await _checkSinglePermission(Permission.locationWhenInUse);

    ///获取第二个状态
    PermissionStatus status2 = PermissionStatus.denied;

    ///如果前置状态为成功才能执行获取第二个状态
    if (status.isGranted) {
      status2 = await _checkSinglePermission(Permission.locationAlways);
    }

    ///如果两个都成功那么就返回成功
    if (status.isGranted && status2.isGranted) {
      return true;

      ///如果有一个拒绝那么就失败了
    } else if (status.isDenied || status2.isDenied) {
      _showFailedDialog(
          [Permission.locationWhenInUse, Permission.locationAlways]);
    } else {
      _showFailedDialog(
        [Permission.locationWhenInUse, Permission.locationAlways],
        isPermanentlyDenied: true,
      );
    }
    return false;
  }

  static _checkSinglePermission(Permission permission) async {
    ///获取当前状态
    PermissionStatus status = await permission.status;
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;

    ///如果它状态不是允许那么就去获取
    if (!status.isGranted) {
      currentPermissionStatus = await _requestPermission([permission]);
    }

    ///返回最终状态
    return currentPermissionStatus;
  }

  /// 访问媒体权限
  static Future<Permission> getMediumPermission({bool isVideo = false}) async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      int sdkVersion = androidInfo.version.sdkInt;
      if (sdkVersion >= 33) {
        return isVideo ? Permission.videos : Permission.photos;
      } else {
        return Permission.storage;
      }
    } else {
      return Permission.photos;
    }
  }

  /// 权限拒绝后弹窗
  static _showFailedDialog(List<Permission> permissionList,
      {bool isPermanentlyDenied = false}) async {
    BotToast.cleanAll();
    String instructions = await _getInstructions(permissionList);
    BotToast.showText(text: instructions);
  }

  /// 获取权限使用说明
  static Future<String> _getInstructions(
      List<Permission> permissionList) async {
    late Permission failedPermission;

    /// 遍历当前权限申请列表
    for (Permission permission in permissionList) {
      PermissionStatus status = await permission.status;

      /// 如果不是允许状态就添加到新的申请列表中
      if (!status.isGranted || !status.isLimited) {
        failedPermission = permission;
        break;
      }
    }
    String instructions = '';
    if (failedPermission == Permission.camera) {
      instructions = '需要您开启摄像头权限，以便为您拍摄照片和录制视频内容。';
    }
    if (failedPermission == Permission.storage) {
      instructions = '需要您开启存储权限，以便为您保存您选择的照片、视频等内容。';
    }
    if (failedPermission == Permission.photos) {
      instructions = '需要您开启照片访问权限，以便为您提供发布或保存您选择的照片内容。';
    }
    if (failedPermission == Permission.videos) {
      instructions = '需要您开启视频访问权限，以便为您提供发布或保存您选择的视频内容。';
    }
    return instructions;
  }

  /// 申请权限时顶部权限说明弹窗
  static _showTopInstructionsDialog(List<Permission> permissionList) async {
    String instructions = await _getInstructions(permissionList);
    BotToast.showCustomNotification(
      dismissDirections: [DismissDirection.up],
      duration: const Duration(hours: 24),
      toastBuilder: (cancel) {
        return IntrinsicHeight(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '权限使用说明',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  instructions,
                  style: const TextStyle(
                    color: Color(0xFF727272),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

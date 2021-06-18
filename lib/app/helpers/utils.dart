import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class Utils {
  static Future<bool> checkConnection(bool toast) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    if (toast) return false;

    Get.snackbar(
      "Atención", // title
      "No tienes conexión a internet", // message
      icon: Icon(
        Icons.warning,
        color: Colors.red.shade600,
      ),
      shouldIconPulse: true,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      backgroundColor: Colors.black38,
      duration: Duration(seconds: 3),
    );
  }

  static getFileName(String path) {
    return basename(path);
  }

  String capitalize(String text) {
    return "${text.substring(0, 1).toUpperCase()}${text.toLowerCase().substring(1)}";
  }
}

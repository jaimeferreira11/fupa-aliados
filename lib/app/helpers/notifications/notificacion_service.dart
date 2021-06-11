import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'notificacion_colors.dart';
import 'notifications_keys.dart';

class NotificationService {
  void mostrarSnackBar(
      {@required String color,
      @required String mensaje,
      @required String titulo,
      SnackPosition position = SnackPosition.BOTTOM}) {
    Get.snackbar('', '',
        snackPosition: position,
        titleText: Text(
          titulo ?? "",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        messageText: Text(
          mensaje ?? "",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        colorText: Colors.white,
        backgroundColor: coloresSnack[color],
        duration: Duration(
          milliseconds: 3000,
        ),
        icon: (color == NotiKey.SUCCESS)
            ? Icon(FontAwesomeIcons.checkCircle)
            : (color == NotiKey.ERROR)
                ? Icon(FontAwesomeIcons.timesCircle)
                : (color == NotiKey.INFO)
                    ? Icon(FontAwesomeIcons.infoCircle)
                    : (color == NotiKey.WARNING)
                        ? Icon(FontAwesomeIcons.walking)
                        : null);
  }

  void mostrarInternalError(
      {@required String mensaje, SnackPosition position = SnackPosition.TOP}) {
    Get.snackbar(
      '',
      '',
      snackPosition: position,
      titleText: Text(
        "Ocurrio un error interno",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        mensaje,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      colorText: Colors.white,
      backgroundColor: coloresSnack[NotiKey.ERROR],
      duration: Duration(
        milliseconds: 2500,
      ),
    );
  }
}

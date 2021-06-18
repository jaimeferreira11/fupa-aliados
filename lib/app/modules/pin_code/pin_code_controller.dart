import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
import 'package:fupa_aliados/app/data/models/sanatorio_producto_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/yes_no_dialog.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  var onTapRecognizer;

  bool workInProgress = false;
  int resendingTokenPhone;
  bool reenviar = false;

  TextEditingController textEditingController = TextEditingController();
  String celular = "";
  String mensaje = "";
  ProformaModel proforma;

  StreamController<ErrorAnimationType> errorController;

  String hasError;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  RxBool buscando = false.obs;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  init() async {
    print(Cache.instance.user.sanatorio.productos.length);
    print(Cache.instance.user.sanatorio.productos[0].toJson());
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        reenviar = true;
        update();
        reenviarCodigo();
      };
    errorController = StreamController<ErrorAnimationType>();
  }

  reenviarCodigo() {
    serverRepo.reenviarCodigo(celular, mensaje);
    noti.mostrarSnackBar(
        color: NotiKey.SUCCESS,
        mensaje: "",
        titulo: "Mensaje reenviado",
        position: SnackPosition.BOTTOM);
  }

  atras() async {
    final dial = await DialogoSiNo()
        .abrirDialogoSiNo('¿Estás seguro?', "Se cancelará el proceso");

    print(dial);
    if (dial == 1) {
      nav.goToAndClean(AppRoutes.SOLICITAR_CREDITO);
    }
  }

  validarSolicitud() async {
    buscando.value = true;
    final resp = await serverRepo.enviarSolicitud(currentText, proforma);
    buscando.value = false;

    resp.fold((l) async {
      if (l is CustomFailure) {
        await DialogoSiNo().abrirDialogoError(l.mensaje);
      } else {
        await DialogoSiNo().abrirDialogoError("Error interno");
      }
    }, (r) async {
      proforma = null;
      celular = "";
      mensaje = "";
      await DialogoSiNo().abrirDialogoSucccess(r);
      nav.goToAndClean(AppRoutes.SOLICITAR_CREDITO);
    });
  }
}

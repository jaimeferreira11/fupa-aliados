import 'dart:async';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/yes_no_dialog.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
//import 'package:fupa_aliados/app/modules/pin_code/pin_code_controller.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SolicitarCreditoController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();
  final responsive = Responsive.of(Get.context);
  // final pinController = Get.find<PinCodeController>();

  double height = Get.size.height * 0.27;
  ClienteModel cliente;
  bool workInProgress = false;

  RxBool buscando = false.obs;

  // inputs
  RxString error = "".obs;
  String doc = "";
  String tipodoc = 'CI';

  RxString error2 = "".obs;
  String monto = "";
  String plazo = '7';
  bool busquedaRealizada = false;
  String montoAux = "";

  int idsanatorioproducto;

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'es-PY',
    decimalDigits: 0,
    symbol: '',
  );

  // Pin controller
  var onTapRecognizer;

  //bool workInProgress = false;
  int resendingTokenPhone;
  bool reenviar = false;

  TextEditingController textEditingController;
  String celular = "";
  String mensaje = "";
  ProformaModel proforma;

  StreamController<ErrorAnimationType> errorController;

  String hasError;
  String currentText = "";
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey;

  //RxBool buscando = false.obs;

  /* Fin Pin Cntroller*/

  @override
  void onReady() {
    if (Cache.instance.user.sanatorio.productos.isNotEmpty)
      idsanatorioproducto =
          Cache.instance.user.sanatorio.productos[0].idsanatorioproducto;

    initPinController();
    super.onReady();
  }

  // Pin controller
  @override
  void onClose() {
    print('Close pin code');
    this.errorController?.close();
  }

  initPinController() async {
    print("Iniciando pin code");

    formKey = GlobalKey<FormState>();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        reenviar = true;
        update();
        reenviarCodigo();
      };
    errorController = StreamController<ErrorAnimationType>();
    textEditingController = TextEditingController();
    update();
  }

  Future comprobarDisponibilidad() async {
    if (doc.isEmpty) {
      error.value = "Campo requerido";
      return;
    }

    workInProgress = true;
    FocusScope.of(Get.context).requestFocus(FocusNode());

    reset();

    final resp = await serverRepo.verificarDisponibilidadCliente(tipodoc, doc);
    workInProgress = false;
    busquedaRealizada = true;
    update();
    resp.fold((l) {
      cliente = null;
      height = responsive.hp(27);
      update();
      if (l is ServerFailure) {
        noti.mostrarInternalError(mensaje: l.mensaje);
      } else {
        noti.mostrarSnackBar(
          color: NotiKey.INFO,
          mensaje: l.mensaje,
          titulo: "Atención",
        );
      }
    }, (r) {
      height = responsive.hp(37);
      cliente = r;
      busquedaRealizada = true;

      update();
    });
  }

  Future solicitarCodigoVerificacion() async {
    error2.value = "";
    if (cliente == null) return;

    if (this.monto.isEmpty) {
      error2.value = "Agregue el monto";
      return;
    }

    if (double.parse(this.monto.trim().replaceAll(".", "")) < 10000) {
      error2.value = "Monto invalido";
      return;
    }

    //  workInProgress = true;
    buscando.value = true;
    FocusScope.of(Get.context).requestFocus(FocusNode());
    update();
    final resp = await serverRepo.solicitarCodigoVerificacion(
        idpersona: cliente.persona.idpersona,
        monto: monto.trim().replaceAll(".", ""),
        plazo: plazo,
        cel: cliente.persona.telefono1);
    //  workInProgress = false;
    buscando.value = false;
    update();
    resp.fold((l) {
      noti.mostrarInternalError(mensaje: l.mensaje);
    }, (r) {
      final newProforma = new ProformaModel(
          idpersona: cliente.persona.idpersona,
          monto: double.parse(monto.trim().replaceAll(".", "")),
          cliente: cliente,
          plazo: int.parse(plazo.trim()),
          idsanatorioproducto: idsanatorioproducto);
      this.celular = cliente.persona.telefono1;
      this.mensaje = r;
      this.proforma = newProforma;
      nav.goToOff(AppRoutes.PIN_CODE);
    });
  }

  reset() {
    error.value = "";
    cliente = null;
    busquedaRealizada = false;
    height = responsive.hp(27);
    update();
  }

  /* Metodos de Pin Controller*/
  reenviarCodigo() {
    serverRepo.reenviarCodigo(celular, mensaje);
    noti.mostrarSnackBar(
        color: NotiKey.SUCCESS,
        mensaje: "",
        titulo: "Mensaje reenviado",
        position: SnackPosition.BOTTOM);
  }

  atrasPinController() async {
    final dial = await DialogoSiNo()
        .abrirDialogoSiNo('¿Estás seguro?', "Se cancelará el proceso");

    print(dial);
    if (dial == 1) {
      nav.goToOff(AppRoutes.SOLICITAR_CREDITO);
    }
  }

  validarSolicitud() async {
    workInProgress = true;
    update(['pin']);

    final resp = await serverRepo.enviarSolicitud(currentText, proforma);
    workInProgress = false;
    update(['pin']);
    resp.fold((l) async {
      if (l is CustomFailure) {
        await DialogoSiNo().abrirDialogoError(l.mensaje);
      } else {
        await DialogoSiNo().abrirDialogoError("Error interno");
      }
      nav.goToAndClean(AppRoutes.SOLICITAR_CREDITO);
    }, (r) async {
      proforma = null;
      celular = "";
      mensaje = "";
      await DialogoSiNo().abrirDialogoSucccess(r);
      nav.goToAndClean(AppRoutes.SOLICITAR_CREDITO);
    });
  }
}

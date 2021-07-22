import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/pin_code/pin_code_controller.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class SolicitarCreditoController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();
  final responsive = Responsive.of(Get.context);
  final pinController = Get.find<PinCodeController>();

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

  @override
  void onReady() {
    if (Cache.instance.user.sanatorio.productos.isNotEmpty)
      idsanatorioproducto =
          Cache.instance.user.sanatorio.productos[0].idsanatorioproducto;

    super.onReady();
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
      final proforma = new ProformaModel(
          idpersona: cliente.persona.idpersona,
          monto: double.parse(monto.trim().replaceAll(".", "")),
          cliente: cliente,
          plazo: int.parse(plazo.trim()),
          idsanatorioproducto: idsanatorioproducto);
      pinController.celular = cliente.persona.telefono1;
      pinController.mensaje = r;
      pinController.proforma = proforma;
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
}

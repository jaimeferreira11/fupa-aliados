import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SolicitudesSegurosController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  RxBool buscando = false.obs;
  String mes;
  String anio;
  List<SolicitudSeguroModel> pendientes = [];
  List<SolicitudSeguroModel> aprobados = [];
  List<SolicitudSeguroModel> rechazados = [];

  var numberFormat = new NumberFormat("###,###", "es_ES");

  @override
  void onReady() async {
    super.onReady();
    _init();
  }

  _init() async {
    obtenerReportes();
  }

  Future<Null> refresh() async {
    await this.obtenerReportes();
    return null;
  }

  Future<void> obtenerReportes() async {
    buscando.value = true;

    final resp = await serverRepo.solicitudesPendientesSeguros();
    resp.fold((l) {
      noti.mostrarInternalError(mensaje: "Error buscando pendientes");
    }, (r) {
      pendientes = r;
      print('Pendientes: ${r.length}');
    });

    final resp1 = await serverRepo.solicitudesAprobadosSeguros();
    resp1.fold((l) {
      noti.mostrarInternalError(mensaje: "Error buscando aprobados");
    }, (r) {
      aprobados = r;
      print('Aprobados: ${r.length}');
    });

    final resp2 = await serverRepo.solicitudesRechazadosSeguros();
    resp2.fold((l) {
      noti.mostrarInternalError(mensaje: "Error buscando rechazados");
    }, (r) {
      rechazados = r;
      print('Rechazados: ${r.length}');
    });

    print('Actualizando');

    buscando.value = false;

    update(['tabs']);
  }

  Future<int> dialogSelectOrigen() async {
    int origen = 0;
    await Get.dialog(AlertDialog(
      title: Text(
        'Seleccione el origen',
        style: TextStyle(color: Colors.black),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              leading: Icon(Icons.camera_alt_outlined),
              title: Text('Camara'),
              onTap: () {
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.pop(context);
                  origen = 1;
                  return origen;
                });
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Galeria'),
              onTap: () {
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.pop(context);
                  origen = 2;
                  return origen;
                });
              },
            ),
            Divider()
          ]);
        },
      ),
    ));

    return origen;
  }

  adjuntarArchivo(int origen, int idsolicitud, String tipo) async {
    if (origen == 1) {
      File pickedFile = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        nav.back();
        buscando.value = true;

        final bytes = await pickedFile.readAsBytes();
        final resp = await serverRepo.subirArchivosSeguros(
            bytes, pickedFile.path, idsolicitud, tipo, "FIRMADO");

        resp.fold((l) {
          noti.mostrarInternalError(mensaje: "Intente mas tarde");
          return;
        }, (r) async {
          final resp = await serverRepo.obtenerSolicitudSeguroById(idsolicitud);

          resp.fold((l) {}, (r) async {
            aprobados.removeWhere((e) => e.idsolicitudseguro == idsolicitud);
            aprobados.add(r);
            update(['tabs']);

            bool isLiquidacionFirmada =
                r.adjuntos.indexWhere((e) => e.tipo == "LIQUIDACION-FIRMADO") >
                    -1;
            bool isFormularioFirmado =
                r.adjuntos.indexWhere((e) => e.tipo == "FORMULARIO-FIRMADO") >
                    -1;

            String mensaje = "Favor suba el otro adjunto";

            if (isFormularioFirmado && isLiquidacionFirmada) {
              await serverRepo.confirmarSolicitudSeguro(idsolicitud);

              aprobados.removeWhere((e) => e.idsolicitudseguro == idsolicitud);
              update(['tabs']);

              mensaje =
                  "¡La operación a sido confirmada! Aparecerá en el menú reportes.";
              buscando.value = false;
            }

            noti.mostrarSuccess(mensaje: mensaje);
          });
        });
      }
    }
    if (origen == 2) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: false,
      );
      if (result != null) {
        nav.back();
        buscando.value = true;

        final file = new File(result.files.first.path);
        final bytes = await file.readAsBytes();
        final resp = await serverRepo.subirArchivosSeguros(
            bytes, file.path, idsolicitud, tipo, "FIRMADO");
        resp.fold((l) {
          buscando.value = false;
          noti.mostrarInternalError(mensaje: l.mensaje);
          return;
        }, (r) async {
          final resp = await serverRepo.obtenerSolicitudSeguroById(idsolicitud);

          resp.fold((l) {
            buscando.value = false;
            noti.mostrarInternalError(mensaje: l.mensaje);
            return;
          }, (r) async {
            aprobados.removeWhere((e) => e.idsolicitudseguro == idsolicitud);
            aprobados.add(r);
            update(['tabs']);

            bool isLiquidacionFirmada =
                r.adjuntos.indexWhere((e) => e.tipo == "LIQUIDACION-FIRMADO") >
                    -1;
            bool isFormularioFirmado =
                r.adjuntos.indexWhere((e) => e.tipo == "FORMULARIO-FIRMADO") >
                    -1;

            String mensaje = "Favor suba el otro adjunto";

            if (isFormularioFirmado && isLiquidacionFirmada) {
              await serverRepo.confirmarSolicitudSeguro(idsolicitud);

              aprobados.removeWhere((e) => e.idsolicitudseguro == idsolicitud);
              update(['tabs']);

              mensaje =
                  "¡La operación a sido confirmada! Aparecerá en el menú reportes.";
              buscando.value = false;
            }
            buscando.value = false;

            noti.mostrarSuccess(mensaje: mensaje);
          });
        });
      }
    }
  }
}

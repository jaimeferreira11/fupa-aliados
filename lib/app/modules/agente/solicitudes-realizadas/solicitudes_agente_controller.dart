import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SolicitudesAgenteController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  RxBool buscando = false.obs;
  String mes;
  String anio;
  List<SolicitudAgenteModel> pendientes = [];
  List<SolicitudAgenteModel> aprobados = [];
  List<SolicitudAgenteModel> rechazados = [];

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

    final resp = await serverRepo.solicitudesPendientesAgente();
    resp.fold((l) {
      noti.mostrarInternalError(mensaje: "Error buscando pendientes");
    }, (r) {
      pendientes = r;
      print('Pendientes: ${r.length}');
    });

    final resp1 = await serverRepo.solicitudesAprobadosAgente();
    resp1.fold((l) {
      noti.mostrarInternalError(mensaje: "Error buscando aprobados");
    }, (r) {
      aprobados = r;
      print('Aprobados: ${r.length}');
    });

    final resp2 = await serverRepo.solicitudesRechazadosAgente();
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
    print('origen: $origen');
    if (origen == 1) {
      File pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        final resp = await serverRepo.subirArchivosAgente(
            bytes, pickedFile.path, idsolicitud, tipo);
        resp.fold((l) {
          noti.mostrarInternalError(mensaje: "Intente mas tarde");
          return;
        }, (r) {
          noti.mostrarSuccess(mensaje: 'Imagen subida');
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
        final file = new File(result.files.first.path);
        final bytes = await file.readAsBytes();
        final resp = await serverRepo.subirArchivosAgente(
            bytes, file.path, idsolicitud, tipo);
        resp.fold((l) {
          noti.mostrarInternalError(mensaje: "Intente mas tarde");
          return;
        }, (r) async {
          buscando.value = true;

          final resp = await serverRepo.solicitudesPendientesAgente();
          buscando.value = false;
          resp.fold((l) {}, (r) {
            pendientes = r;
            print('Pendientes: ${r.length}');
            update(['tabs']);
          });

          noti.mostrarSuccess(
              mensaje: 'Cierre esta ventana para ver el archivo nuevo');
        });
      }
    }
  }
}

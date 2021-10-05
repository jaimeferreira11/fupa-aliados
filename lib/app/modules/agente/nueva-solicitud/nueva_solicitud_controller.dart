import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/persona_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/yes_no_dialog.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NuevaSolicitudController extends GetxController {
  final authRepo = Get.find<AuthRepository>();
  final serverRepo = Get.find<ServerRepository>();
  final nav = Get.find<NavigatorController>();
  final noti = Get.find<NotificationService>();

  RxBool buscando = false.obs;
  var form1Key = GlobalKey<FormState>();
  var form2Key = GlobalKey<FormState>();
  var form3Key = GlobalKey<FormState>();
  var form4Key = GlobalKey<FormState>();
  var form5Key = GlobalKey<FormState>();

  List<File> cedulas;
  List<File> inforconf;
  File fotoCliente;

  SolicitudAgenteModel agente;
  String doc;
  String tipodoc = 'CI';

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'es-PY',
    decimalDigits: 0,
    symbol: '',
  );

  var numberFormat = new NumberFormat("###,###", "es_ES");

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    this.cedulas = [];
    this.inforconf = [];

    if (Cache.instance.agenteParametro == null) {
      final resp = await serverRepo.obtenerParametrosAgente();
      resp.fold((l) {
        noti.mostrarInternalError(mensaje: l.mensaje);
        nav.back();
      }, (r) => Cache.instance.agenteParametro = r);
    }

    if (Cache.instance.agenteDestinos == null) {
      final resp = await serverRepo.obtenerDestinosAgente();
      resp.fold((l) {
        noti.mostrarInternalError(mensaje: l.mensaje);
        nav.back();
      }, (r) => Cache.instance.agenteDestinos = r);
    }
  }

  Future<bool> back() async {
    final dial = await DialogoSiNo()
        .abrirDialogoSiNo('¿Estás seguro?', "Se cancelará el proceso");

    print(dial);
    if (dial == 1) {
      nav.back();
      return true;
    }

    return false;
  }

  onNext(int currentStep) async {
    switch (currentStep) {
      case 1:
        await buscarCliente();
        break;
      default:
    }
  }

  Future buscarCliente() async {
    if (this.doc.isEmpty) {
      return;
    }

    FocusScope.of(Get.context).requestFocus(FocusNode());
    this.buscando.value = true;

    final resp =
        await serverRepo.buscarClienteByTipoDocAndDoc(this.tipodoc, this.doc);
    this.buscando.value = false;
    this.agente = new SolicitudAgenteModel(
        otrosingresos: '0',
        tipovivienda: 'PROPIA',
        destino: Cache.instance.agenteDestinos.first.descripcion);
    resp.fold((l) {
      this.agente.cliente = new ClienteModel(
          idcliente: 0,
          persona: new PersonaModel(nrodoc: this.doc, estado: true),
          estado: true);
    }, (r) {
      this.agente.cliente = r;
    });
    update();
  }

  onComplete() async {
    print(this.agente.toJson());
    final dialog = await DialogoSiNo().abrirDialogoSiNo(
        "¿Enviar solicitud?", "Recuerda que debes tener conexión a internet");

    if (dialog == 1) {
      buscando.value = true;
      this.agente.referencia1 =
          '${this.agente.referencia1} - ${this.agente.telefonoReferencia1}';
      this.agente.referencia2 =
          '${this.agente.referencia2} - ${this.agente.telefonoReferencia2}';

      final resp = await serverRepo.enviarSolicitudAgente(agente);

      resp.fold((l) async {
        this.buscando.value = false;
        if (l is CustomFailure) {
          await DialogoSiNo().abrirDialogoError(l.mensaje);
        } else {
          await DialogoSiNo().abrirDialogoError("Error interno");
        }
      }, (r) async {
        await subirArchivos(r);
      });
    }
  }

  subirArchivos(int idsolicitud) async {
    int cont = 0;

    await Future.forEach(this.cedulas, (ci) async {
      print('Subiendo cedula ... ${cont + 1}');

      print('Esperando 0.2 segundos .. ');
      await Future.delayed(Duration(milliseconds: 200), () async {
        final bytes = await ci.readAsBytes();
        final resp = await serverRepo.subirArchivosAgente(
            bytes, ci.path, idsolicitud, "CEDULA");
        resp.fold((l) {
          noti.mostrarInternalError(mensaje: "Intente mas tarde");
          return;
        }, (r) {
          cont++;
        });
      });
    });

    await Future.forEach(this.inforconf, (inf) async {
      print('Subiendo inforconf ... ${cont + 1}');

      print('Esperando 0.2 segundos .. ');
      await Future.delayed(Duration(milliseconds: 200), () async {
        final bytes = await inf.readAsBytes();

        final resp = await serverRepo.subirArchivosAgente(
            bytes, inf.path, idsolicitud, "AUTORIZACION INFORCONF");
        resp.fold((l) {
          noti.mostrarInternalError(mensaje: "Intente mas tarde");
          return;
        }, (r) => cont++);
      });
    });

    print('Esperando 0.2 segundos .. ');
    await Future.delayed(Duration(milliseconds: 200), () async {
      final bytes = await fotoCliente.readAsBytes();

      final resp = await serverRepo.subirArchivosAgente(
          bytes, fotoCliente.path, idsolicitud, "FOTO-CLIENTE");
      resp.fold((l) {
        noti.mostrarInternalError(mensaje: "Intente mas tarde");
        return;
      }, (r) => cont++);
    });

    print('Total: $cont');
    this.buscando.value = false;
    noti.mostrarSuccess(
        position: SnackPosition.BOTTOM,
        mensaje: "$cont archivos subidos",
        titulo: "Subida exitosa");

    await DialogoSiNo()
        .abrirDialogoSucccess("Solciitud nro. 000$idsolicitud enviado");
    nav.goToAndClean(AppRoutes.HOME);
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

  adjuntarCI(int origen) async {
    print('origen: $origen');
    if (origen == 1) {
      File pickedFile = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        this.cedulas.add(pickedFile);
        this.cedulas = getlastsElments(this.cedulas, 2);
        update(['adjuntos']);
        return;
      }
    }
    if (origen == 2) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: true,
      );
      if (result != null) {
        result.files.forEach((e) {
          this.cedulas.add(File(e.path));
        });

        this.cedulas = getlastsElments(this.cedulas, 2);
        update(['adjuntos']);
        return;
      }
    }
  }

  adjuntarInforconf(int origen) async {
    print('origen: $origen');
    if (origen == 1) {
      File pickedFile = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        this.inforconf.add(pickedFile);
        update(['adjuntos']);
        return;
      }
    }
    if (origen == 2) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: true,
      );
      if (result != null) {
        result.files.forEach((e) {
          this.inforconf.add(File(e.path));
        });

        update(['adjuntos']);
        return;
      }
    }
  }

  adjuntarFotoCliente(int origen) async {
    print('origen: $origen');
    if (origen == 1) {
      File pickedFile = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        this.fotoCliente = pickedFile;
        update(['adjuntos']);
        return;
      }
    }
    if (origen == 2) {
      FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: false,
      );
      if (result != null) {
        this.fotoCliente = new File(result.files.first.path);
        update(['adjuntos']);
        return;
      }
    }
  }

  getlastsElments(List<File> list, int limit) {
    if (list.length <= limit) return list;

    List<File> aux = [];
    for (var i = (limit - 1); i >= 0; i--) {
      aux.add(list.reversed.skip(i).first);
    }
    print('aux: ${aux.length}');
    return aux;
  }
}

import 'dart:io';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/config/errors/failures.dart';
import 'package:fupa_aliados/app/data/models/beneficiario_seguro_model.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/persona_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/data/repositories/local/auth_repository.dart';
import 'package:fupa_aliados/app/data/repositories/remote/server_repository.dart';
import 'package:fupa_aliados/app/globlas_widgets/yes_no_dialog.dart';
import 'package:fupa_aliados/app/helpers/notifications/notificacion_service.dart';
import 'package:fupa_aliados/app/helpers/notifications/notifications_keys.dart';
import 'package:fupa_aliados/app/helpers/utils.dart';
import 'package:fupa_aliados/app/modules/seguros/nueva-solicitud/local_widgets/step_actividad_economica.dart';
import 'package:fupa_aliados/app/modules/seguros/nueva-solicitud/local_widgets/step_beneficiarios.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/routes/navigator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'local_widgets/step1_view.dart';
import 'local_widgets/step2_view.dart';
import 'local_widgets/step3_view.dart';
import 'local_widgets/step4_view.dart';
import 'local_widgets/step5_view.dart';

class NuevaSolicitudSegurosController extends GetxController {
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

  List tipoParentezcoList = [
    {"id": 1, "descripcion": "CÓNGUGE"},
    {"id": 2, "descripcion": "HIJO/A"},
  ];
  List<File> cedulas;
  //List<File> inforconf;
  //File fotoCliente;

  SolicitudSeguroModel agente;
  String doc;
  String tipodoc = 'CI';

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'es-PY',
    decimalDigits: 0,
    symbol: '',
  );

  FocusNode nameFocus = FocusNode();

  var numberFormat = new NumberFormat("###,###", "es_ES");
  List<CoolStep> steps = [];

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  _init() async {
    this.cedulas = [];

    steps.add(CoolStep(
        title: "Cliente",
        subtitle: "Ingrese el tipo y número de documento del titular",
        content: Step1View(),
        validation: () {
          if (!form1Key.currentState.validate()) {
            return 'Favor, complete los campos';
          }
          return null;
        }));

    steps.add(CoolStep(
        title: "Datos Pesonales Titular",
        subtitle: "Información personal del titular",
        content: Step2View(),
        validation: () {
          if (!form2Key.currentState.validate()) {
            return 'Favor, complete los campos';
          }
          return null;
        }));

    steps.add(CoolStep(
        title: "Actividad Economica",
        subtitle: "Ingrese los datos económicos del cliente",
        content: StepActividadEconomicaView(),
        validation: () {
          if (!form3Key.currentState.validate()) {
            return 'Favor, complete los campos';
          }
          return null;
        }));

    steps.add(CoolStep(
        title: "Adjuntar cédula titular",
        subtitle: "Adjunte ambos lados del documento de identidad del titular.",
        content: Step3View(),
        validation: () {
          if (cedulas.length < 2) {
            return 'Adjuntá la cedula del cliente';
          }

          return null;
        }));

    steps.add(CoolStep(
        title: "Tipo de cobertura",
        subtitle: "Seleccione el tipo de seguro",
        content: Step4View(),
        validation: () {
          if (agente.tiposeguro == null || agente.tiposeguro.isEmpty) {
            return 'Favor, seleccione el tipo de seguro';
          }
          return null;
        }));

    steps.add(CoolStep(
        title: "Resumen",
        subtitle: "Verifique que los datos sean correctos",
        content: Step5View(),
        validation: () {
          return null;
        }));

    update();
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
    print('currentStep: $currentStep');

    if (currentStep > 2) {
      doc = "";
      tipodoc = "CI";
    }

    switch (currentStep) {
      case 1:
        await buscarCliente();
        break;
      case 5:
        if (steps.length > 6) return;
        print('Selecciono Familiar');

        if (agente.tiposeguro == "FAMILIAR") {
          agente.beneficiarios.add(new BeneficiarioSeguroModel(
              idparentezco: 1,
              filesList: [],
              persona: new PersonaModel(
                  idpersona: 0, nrodoc: this.doc, estado: true)));
          agente.beneficiarios.add(new BeneficiarioSeguroModel(
              idparentezco: 2,
              filesList: [],
              persona: new PersonaModel(
                  idpersona: 0, nrodoc: this.doc, estado: true)));
          agente.beneficiarios.add(new BeneficiarioSeguroModel(
              idparentezco: 2,
              filesList: [],
              persona: new PersonaModel(
                  idpersona: 0, nrodoc: this.doc, estado: true)));
          agente.beneficiarios.add(new BeneficiarioSeguroModel(
              idparentezco: 2,
              filesList: [],
              persona: new PersonaModel(
                  idpersona: 0, nrodoc: this.doc, estado: true)));
          print("Insertando un step");
          steps.insert(
              5,
              CoolStep(
                  title: "Datos del cónyuge",
                  subtitle: "Debe ser menor a 80 años",
                  content: StepBeneficiariosView(
                    index: 0,
                  ),
                  validation: () {
                    if (!personaOK(agente.beneficiarios[0].persona)) {
                      return "EL conyugue es obligatorio";
                    }
                    final edadValidation = edadValida(
                        agente.beneficiarios[0].persona.fechanaciemiento, 1);

                    if (!edadValidation['ok']) {
                      return edadValidation['msg'];
                    }
                    if (agente.beneficiarios[0].filesList.length == 0)
                      return "Suba la foto del documento de identidad";
                    return null;
                  }));
          steps.insert(
              6,
              CoolStep(
                  title: "Datos del hijo #1",
                  subtitle: "Debe ser menor a 21 años",
                  content: StepBeneficiariosView(
                    index: 1,
                  ),
                  validation: () {
                    final p = agente.beneficiarios[1].persona;
                    if (p.nrodoc != null && p.nrodoc.isNotEmpty) {
                      if (personaOK(p)) {
                        final edadValidation =
                            edadValida(p.fechanaciemiento, 2);

                        if (!edadValidation['ok']) {
                          return edadValidation['msg'];
                        }

                        if (agente.beneficiarios[1].filesList.length == 0)
                          return "Suba la foto del documento de identidad";
                      } else {
                        return "Complete los datos del beneficiario";
                      }
                    }
                    return null;
                  }));
          steps.insert(
              7,
              CoolStep(
                  title: "Datos del hijo #2",
                  subtitle: "Debe ser menor a 21 años",
                  content: StepBeneficiariosView(index: 2),
                  validation: () {
                    final p = agente.beneficiarios[2].persona;
                    if (p.nrodoc != null && p.nrodoc.isNotEmpty) {
                      if (personaOK(p)) {
                        final edadValidation =
                            edadValida(p.fechanaciemiento, 2);

                        if (!edadValidation['ok']) {
                          return edadValidation['msg'];
                        }

                        if (agente.beneficiarios[2].filesList.length == 0)
                          return "Suba la foto del documento de identidad";
                      } else {
                        return "Complete los datos del beneficiario";
                      }
                    }
                    return null;
                  }));
          steps.insert(
              8,
              CoolStep(
                  title: "Datos del hijo #3",
                  subtitle: "Debe ser menor a 21 años",
                  content: StepBeneficiariosView(index: 3),
                  validation: () {
                    final p = agente.beneficiarios[3].persona;
                    if (p.nrodoc != null && p.nrodoc.isNotEmpty) {
                      if (personaOK(p)) {
                        final edadValidation =
                            edadValida(p.fechanaciemiento, 2);

                        if (!edadValidation['ok']) {
                          return edadValidation['msg'];
                        }
                        if (agente.beneficiarios[3].filesList.length == 0)
                          return "Suba la foto del documento de identidad";
                      } else {
                        return "Complete los datos del beneficiario";
                      }
                    }
                    return null;
                  }));

          update();
        }
        break;
      case 5:
        // si no llena el beneficio 1, ir al resumen

        break;
      case 6:
        // si no llena el beneficio 1, ir al resumen

        break;
      case 7:
        // si no llena el beneficio 1, ir al resumen

        break;

      default:
    }
  }

  bool personaOK(PersonaModel persona) {
    print(persona.toJson());
    if (persona.nrodoc == null ||
        persona.nombres == null ||
        persona.fechanaciemiento == null ||
        persona.apellidos == null) return false;

    if (persona.nrodoc.isEmpty ||
        persona.nombres.isEmpty ||
        persona.fechanaciemiento.isEmpty ||
        persona.apellidos.isEmpty) return false;

    return true;
  }

  Future buscarCliente() async {
    print('Buscando cliente: ${this.doc}');
    if (this.doc.isEmpty) {
      return;
    }

    FocusScope.of(Get.context).requestFocus(FocusNode());
    this.buscando.value = true;

    final resp =
        await serverRepo.buscarClienteByTipoDocAndDoc(this.tipodoc, this.doc);
    this.buscando.value = false;
    this.agente = new SolicitudSeguroModel(beneficiarios: []);
    resp.fold((l) {
      this.agente.beneficiarios = [];
      this.agente.cliente = new ClienteModel(
          idcliente: 0,
          persona: new PersonaModel(nrodoc: this.doc, estado: true),
          estado: true);
    }, (r) {
      this.agente.cliente = r;
    });
    update();
  }

  Future<PersonaModel> buscarPersona(
      {@required String doc, @required String tipodoc}) async {
    print('Buscando persona: ${this.doc}');
    if (this.doc.isEmpty) {
      return null;
    }

    FocusScope.of(Get.context).requestFocus(FocusNode());
    this.buscando.value = true;

    final resp =
        await serverRepo.buscarPersonaByTipoDocAndDoc(this.tipodoc, this.doc);
    this.buscando.value = false;

    return resp.fold((l) {
      noti.mostrarSnackBar(
          color: NotiKey.INFO,
          mensaje: "Complete los datos del beneficiario",
          titulo: "No encontrado");
      nameFocus.requestFocus();
      return new PersonaModel(
          idpersona: 0,
          nrodoc: this.doc,
          estado: true,
          sexo: "M",
          tipopersona: "FISICA");
    }, (r) {
      return r;
    });
  }

  onComplete() async {
    final dialog = await DialogoSiNo().abrirDialogoSiNo(
        "¿Enviar solicitud?", "Recuerda que debes tener conexión a internet");

    if (dialog == 1) {
      buscando.value = true;

      print("Antes: ${agente.beneficiarios.length}");
      agente.beneficiarios.removeWhere((e) => e.persona.nrodoc.isEmpty);
      print("Despues: ${agente.beneficiarios.length}");

      final resp = await serverRepo.enviarSolicitudSeguros(agente);

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
        final resp = await serverRepo.subirArchivosSeguros(
            bytes, ci.path, idsolicitud, "CEDULA", "TITULAR");
        resp.fold((l) {
          noti.mostrarInternalError(mensaje: "Intente mas tarde");
          return;
        }, (r) {
          cont++;
        });
      });
    });
    await Future.forEach(this.agente.beneficiarios, (b) async {
      int aux = 1;
      await Future.forEach(b.filesList, (file) async {
        print('Esperando 0.2 segundos .. ');
        await Future.delayed(Duration(milliseconds: 200), () async {
          print('Subiendo beneficiario... ${aux}');
          final bytes = await file.readAsBytes();

          final resp = await serverRepo.subirArchivosSeguros(
              bytes, file.path, idsolicitud, "adjunto$aux", b.persona.nrodoc);
          aux = aux + 1;
          resp.fold((l) {
            noti.mostrarInternalError(mensaje: "Intente mas tarde");
            return;
          }, (r) => cont++);
        });
      });
    });

    print('Total: $cont');
    this.buscando.value = false;
    noti.mostrarSuccess(
        mensaje: "$cont archivos subidos", titulo: "Subida exitosa");

    await DialogoSiNo()
        .abrirDialogoSucccess("Solicitud nro. $idsolicitud enviado");
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
    FocusScope.of(Get.context).unfocus();
  }

  adjuntarCIBeneficiario(int origen, int index) async {
    print('origen: $origen , index: $index');
    if (origen == 1) {
      File pickedFile = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 25);

      if (pickedFile != null) {
        this.agente.beneficiarios[index].filesList.add(pickedFile);
        this.agente.beneficiarios[index].filesList =
            getlastsElments(this.agente.beneficiarios[index].filesList, 2);
        update();
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
          this.agente.beneficiarios[index].filesList.add(File(e.path));
        });

        this.agente.beneficiarios[index].filesList =
            getlastsElments(this.agente.beneficiarios[index].filesList, 2);
        update();
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

  dynamic edadValida(String value, int idtipoparentezco) {
    try {
      DateTime fecha = new DateFormat("yyyy-MM-dd").parse(value);

      int age = Utils.calculateAge(fecha);

      if (idtipoparentezco == 1) {
        if (age < 18)
          return {"ok": false, "msg": 'El asegurado debe ser mayor de edad'};
        if (age > 80)
          return {"ok": false, "msg": 'El asegurado debe ser mayor de edad'};
      } else {
        if (age > 21)
          return {"ok": false, "msg": 'El beneficiario debe ser hasta 21 años'};
      }

      return {"ok": true};
    } catch (e) {
      return {"ok": false, "msg": 'Fecha no valida'};
    }
  }
}

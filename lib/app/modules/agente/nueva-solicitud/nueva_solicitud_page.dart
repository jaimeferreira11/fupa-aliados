import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/globlas_widgets/buscando_progress_w.dart';
import 'package:fupa_aliados/app/globlas_widgets/custom_stepper.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/local_widgets/step1_view.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'local_widgets/step2_view.dart';
import 'local_widgets/step3_view.dart';
import 'local_widgets/step4_view.dart';
import 'local_widgets/step5_view.dart';
import 'local_widgets/step6_view.dart';

class NuevaSolcitudPage extends StatelessWidget {
  const NuevaSolcitudPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<NuevaSolicitudController>(
          builder: (_) => WillPopScope(
                onWillPop: _.back,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Scaffold(
                        appBar: AppBar(title: Text('Nueva solicitud')),
                        body: _BuildMainStepper(),
                      ),
                      BuscandoProgressWidget(buscando: _.buscando),
                    ],
                  ),
                ),
              )),
    );
  }
}

class _BuildMainStepper extends StatelessWidget {
  const _BuildMainStepper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NuevaSolicitudController>(
      builder: (_) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomStepper(
          onCompleted: () {},
          onNext: _.onNext,
          onBack: (currentStep) {
            print('Back to $currentStep');
          },
          steps: [
            CoolStep(
                title: "Cliente",
                subtitle: "Ingrese el tipo y número de documento del cliente",
                content: Step1View(),
                validation: () {
                  print(_.form1Key.currentState.validate());
                  if (!_.form1Key.currentState.validate()) {
                    return 'Favor, complete los campos';
                  }
                  return null;
                }),
            CoolStep(
                title: "Datos Pesonales",
                subtitle: "Información personal del cliente",
                content: Step2View(),
                validation: () {
                  /* print(_.form4Key.currentState.validate());
                  if (!_.form4Key.currentState.validate()) {
                    return 'Favor, complete los campos';
                  } */
                  return null;
                }),
            CoolStep(
                title: "Actividad Economica",
                subtitle: "Ingrese los datos económicos del cliente",
                content: Step3View(),
                validation: () {
                  /* print(_.form4Key.currentState.validate());
                  if (!_.form4Key.currentState.validate()) {
                    return 'Favor, complete los campos';
                  } */
                  return null;
                }),
            CoolStep(
                title: "Residencia y referencias",
                subtitle:
                    "Ingrese otros datos de vida y residencia del cliente",
                content: Step4View(),
                validation: () {
                  /* print(_.form4Key.currentState.validate());
                  if (!_.form4Key.currentState.validate()) {
                    return 'Favor, complete los campos';
                  } */
                  return null;
                }),
            CoolStep(
                title: "Datos de la solicitud",
                subtitle:
                    "Monto entre G. ${_.numberFormat.format(Cache.instance.agenteParametro.montomin)} y G. ${_.numberFormat.format(Cache.instance.agenteParametro.montomax)} y plazo entre ${_.numberFormat.format(Cache.instance.agenteParametro.cuotasmin)} a ${_.numberFormat.format(Cache.instance.agenteParametro.cuotasmax)} cuotas.",
                content: Step5View(),
                validation: () {
                  /* print(_.form4Key.currentState.validate());
                  if (!_.form4Key.currentState.validate()) {
                    return 'Favor, complete los campos';
                  } */
                  return null;
                }),
            CoolStep(
                title: "Documentos adjuntos",
                subtitle:
                    "Adjunte ambos lados del documento de identidad del cliente junto con el reporte de inforconf.",
                content: Step6View(),
                validation: () {}),
          ],
        ),
        /*  CoolStepper(
                showErrorSnackbar: true,
                config: CoolStepperConfig(
                    backText: 'ATRAS',
                    nextText: 'SIGUIENTE',
                    stepText: "Paso",
                    ofText: 'de',
                    finalText: "FINALIZAR"),
                steps: [
                  
                onCompleted: () {}), */
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/buscando_progress_w.dart';
import 'package:fupa_aliados/app/globlas_widgets/custom_stepper.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'nueva_solicitud_seguros_controller.dart';

class NuevaSolcitudSegurosPage extends StatelessWidget {
  const NuevaSolcitudSegurosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<NuevaSolicitudSegurosController>(
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
    return GetBuilder<NuevaSolicitudSegurosController>(
      builder: (_) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomStepper(
            onCompleted: _.onComplete,
            onNext: _.onNext,
            onBack: (currentStep) {
              print('Back to $currentStep');
            },
            steps: _.steps),
      ),
    );
  }
}

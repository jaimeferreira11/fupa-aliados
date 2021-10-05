import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/seguros/nueva-solicitud/nueva_solicitud_seguros_controller.dart';
import 'package:get/get.dart';

class Step1View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudSegurosController>(
        builder: (_) => Form(
            key: _.form1Key,
            child: Column(
              children: [
                InputSelectWidget(
                  value: _.tipodoc,
                  fontSize: responsive.dp(1.8),
                  label: 'Tipo Documento',
                  options: ['CI', 'RUC', 'DNI', 'PASS'],
                  onChanged: (text) {
                    _.tipodoc = text;
                  },
                ),
                SizedBox(height: responsive.hp(2)),
                InputWidget(
                  label: 'Numero de documento',
                  valor: _.doc,
                  keyboardType: TextInputType.number,
                  fontSize: responsive.dp(1.8),
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'El documento es requerido';
                    return null;
                  },
                  onChanged: (text) {
                    _.doc = text;
                  },
                )
              ],
            )));
  }
}

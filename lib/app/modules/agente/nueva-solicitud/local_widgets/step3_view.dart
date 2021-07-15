import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:get/get.dart';

class Step3View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudController>(
        builder: (_) => Form(
            key: _.form3Key,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                InputWidget(
                  label: 'Lugar de trabajo',
                  fontSize: responsive.dp(1.8),
                  valor: _.agente.lugartrabajo ?? '',
                  onChanged: (text) {
                    _.agente.lugartrabajo = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Cargo que ocupa',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.cargo ?? '',
                  onChanged: (text) {
                    _.agente.cargo = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Antigüedad',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.antiguedad ?? '',
                  onChanged: (text) {
                    _.agente.antiguedad = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Salario (G)',
                  inputFormatters: [_.formatter],
                  keyboardType: TextInputType.number,
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.salario ?? '',
                  onChanged: (text) {
                    _.agente.salario = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Dirección trabajo',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.direcciontrabajo ?? '',
                  onChanged: (text) {
                    _.agente.direcciontrabajo = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Telefono trabajo',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.telefonotrabajo ?? '',
                  onChanged: (text) {
                    _.agente.telefonotrabajo = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Ciudad trabajo',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.ciudadtrabajo ?? '',
                  onChanged: (text) {
                    _.agente.ciudadtrabajo = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
              ],
            )));
  }
}

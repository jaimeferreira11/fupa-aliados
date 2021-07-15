import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';

class Step4View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudController>(
        builder: (_) => Form(
            key: _.form4Key,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                InputSelectWidget(
                  value: _.agente.tipovivienda ?? "FISICA",
                  fontSize: responsive.dp(1.8),
                  label: 'Tipo vivienda',
                  options: ['FISICA', 'JURIDICA'],
                  onChanged: (text) {
                    print(text);
                    _.agente.tipovivienda = text;
                  },
                ),
                InputWidget(
                  label: 'Profesión',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.profesion ?? '',
                  onChanged: (text) {
                    _.agente.profesion = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Monto de otros ingresos (G)',
                  inputFormatters: [_.formatter],
                  keyboardType: TextInputType.number,
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.otrosingresos ?? '0',
                  onChanged: (text) {
                    _.agente.otrosingresos = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(0.5)),
                Divider(),
                SizedBox(height: responsive.hp(0.5)),
                Text(
                  'Referencia personal #1',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: responsive.dp(1.8),
                      color: AppColors.primaryColor),
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Nombre y apellido',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.profesion ?? '',
                  onChanged: (text) {
                    _.agente.profesion = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Telefono/Celular',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.profesion ?? '',
                  onChanged: (text) {
                    _.agente.profesion = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                Text(
                  'Referencia personal #2',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: responsive.dp(1.8),
                      color: AppColors.primaryColor),
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Nombre y apellido',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.profesion ?? '',
                  onChanged: (text) {
                    _.agente.profesion = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0)
                      return 'Este campo es requerido';
                    return null;
                  },
                ),
                SizedBox(height: responsive.hp(1)),
                InputWidget(
                  label: 'Telefono/Celular',
                  fontSize: responsive.dp(1.8),
                  // error: _.error2.value,
                  valor: _.agente.profesion ?? '',
                  onChanged: (text) {
                    _.agente.profesion = text;
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:get/get.dart';

class Step5View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudController>(
        builder: (_) => Form(
            key: _.form5Key,
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                GetBuilder<NuevaSolicitudController>(
                  id: 'montoPrestamo',
                  builder: (_) => RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) {
                      if (event.logicalKey == LogicalKeyboardKey.backspace) {
                        print('backspace clicked');
                        print('${_.agente.monto.round()}');
                        if ('${_.agente.monto.round()}'.length == 1) {
                          _.agente.monto = 0;
                          _.update(['montoPrestamo']);
                          print('seteando en cero');
                        }
                      }
                    },
                    child: InputWidget(
                      label: 'Monto (G)',
                      inputFormatters: [_.formatter],
                      keyboardType: TextInputType.number,
                      fontSize: responsive.dp(1.8),
                      // error: _.error2.value,
                      valor: _.agente.monto != null
                          ? '${_.agente.monto.round()}'
                          : '',
                      onChanged: (text) {
                        _.agente.monto = double.parse(text.replaceAll(".", ""));
                      },
                      validator: (value) {
                        if (value == null || value.length == 0)
                          return 'Este campo es requerido';

                        if (Cache.instance.agenteParametro.montomax <
                            double.parse(value.replaceAll(".", "")))
                          return 'El monto maximo es G. ${_.numberFormat.format(Cache.instance.agenteParametro.montomax)}';
                        if (Cache.instance.agenteParametro.montomin >
                            double.parse(value.replaceAll(".", "")))
                          return 'El monto minimo es G. ${_.numberFormat.format(Cache.instance.agenteParametro.montomin)}';

                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(1)),
                InputSelectWidget(
                  value: _.agente.cantidadcuota.toString(),
                  fontSize: responsive.dp(1.8),
                  label: 'Cantidad cuotas (Mensual)',
                  requerido: true,
                  options: List<String>.generate(
                      Cache.instance.agenteParametro.cuotasmax,
                      (i) => (i + 1).toString()),
                  onChanged: (text) {
                    _.agente.cantidadcuota =
                        text.isEmpty ? null : int.parse(text);
                  },
                  // validator: (value) {
                  //   if (Cache.instance.agenteParametro.cuotasmax <
                  //       int.parse(value.replaceAll(".", "")))
                  //     return 'El plazo maximo es de ${Cache.instance.agenteParametro.cuotasmax} cuotas';

                  //   if (Cache.instance.agenteParametro.cuotasmin >
                  //       int.parse(value.replaceAll(".", "")))
                  //     return 'El plazo minimo es de ${Cache.instance.agenteParametro.cuotasmin} cuotas';

                  //   return null;
                  // },
                ),
                // InputWidget(
                //   label: 'Cantidad cuotas (Mensual)',
                //   maxLength:
                //       '${Cache.instance.agenteParametro.cuotasmax}'.length,
                //   keyboardType: TextInputType.number,
                //   fontSize: responsive.dp(1.8),
                //   // error: _.error2.value,
                //   valor: _.agente.cantidadcuota != null
                //       ? _.agente.cantidadcuota.toString()
                //       : '',
                //   onChanged: (text) {
                //     _.agente.cantidadcuota =
                //         text.isEmpty ? null : int.parse(text);
                //   },
                //   validator: (value) {
                //     if (value == null || value.length == 0)
                //       return 'Este campo es requerido';

                //     if (Cache.instance.agenteParametro.cuotasmax <
                //         int.parse(value.replaceAll(".", "")))
                //       return 'El plazo maximo es de ${Cache.instance.agenteParametro.cuotasmax} cuotas';

                //     if (Cache.instance.agenteParametro.cuotasmin >
                //         int.parse(value.replaceAll(".", "")))
                //       return 'El plazo minimo es de ${Cache.instance.agenteParametro.cuotasmin} cuotas';

                //     return null;
                //   },
                // ),
                InputSelectWidget(
                  value: _.agente.destino ??
                      Cache.instance.agenteDestinos.first.descripcion,
                  fontSize: responsive.dp(1.8),
                  label: 'Destino del crédito',
                  options: Cache.instance.agenteDestinos
                          .map((e) => e.descripcion)
                          .toList() ??
                      [],
                  onChanged: (text) {
                    _.agente.destino = text;
                  },
                ),
              ],
            )));
  }
}

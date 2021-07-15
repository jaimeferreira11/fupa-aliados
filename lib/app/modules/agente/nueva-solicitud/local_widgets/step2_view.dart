import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:get/get.dart';

class Step2View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudController>(
        builder: (_) => Container(
            child: _.agente == null
                ? Container()
                : Form(
                    key: _.form2Key,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Text(
                            '${_.tipodoc} - ${_.numberFormat.format(int.parse(_.doc))}',
                            style: TextStyle(
                                fontSize: responsive.dp(1.8),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        InputWidget(
                          label: 'Nombres',
                          fontSize: responsive.dp(1.8),
                          editable: _.agente.cliente?.idcliente == null,
                          // error: _.error2.value,
                          valor: _.agente.cliente.persona?.nombres ?? '',
                          onChanged: (text) {
                            //   _.monto = text;
                          },
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        InputWidget(
                          editable: _.agente.cliente.idcliente == null,
                          label: 'Apellidos',
                          fontSize: responsive.dp(1.8),
                          // error: _.error2.value,
                          valor: _.agente.cliente.persona.apellidos ?? '',
                          onChanged: (text) {
                            //   _.monto = text;
                          },
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        InputWidget(
                          editable: _.agente.cliente.idcliente == null,

                          label: 'Fecha de nacimiento (DD/MM/AAAA)',
                          placeHolder: 'DD/MM/AAAA',
                          fontSize: responsive.dp(1.8),
                          // error: _.error2.value,
                          valor:
                              _.agente.cliente.persona.fechanaciemiento ?? '',
                          onChanged: (text) {
                            //   _.monto = text;
                          },
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        InputSelectWidget(
                          editable: _.agente.cliente.idcliente == null,
                          // value: _.tipodoc,
                          value:
                              _.agente.cliente.persona.tipopersona ?? 'FISICA',
                          fontSize: responsive.dp(1.8),
                          label: 'Tipo persona',
                          options: ['FISICA', 'JURIDICA'],
                          onChanged: (text) {
                            print(text);
                            // _.tipodoc = text;
                          },
                        ),
                        SizedBox(height: responsive.hp(2)),
                        InputWidget(
                          editable: _.agente.cliente.idcliente == null,
                          valor: _.agente.cliente.persona.telefono1 ?? '',
                          label: 'Telefono/Celular',
                        )
                      ],
                    ),
                  )));
  }
}

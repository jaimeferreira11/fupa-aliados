import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/helpers/upper_case_text_formatter.dart';
import 'package:fupa_aliados/app/helpers/utils.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          fontSize: responsive.dp(1.8),
                          editable: _.agente.cliente?.idcliente == 0,
                          // error: _.error2.value,
                          valor: _.agente.cliente.persona?.nombres ?? '',
                          onChanged: (text) {
                            _.agente.cliente.persona.nombres = text;
                          },
                          validator: (value) {
                            if (value == null || value.length == 0)
                              return 'Este campo es requerido';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        InputWidget(
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                          editable: _.agente.cliente.idcliente == 0,
                          label: 'Apellidos',
                          fontSize: responsive.dp(1.8),
                          // error: _.error2.value,
                          valor: _.agente.cliente.persona.apellidos ?? '',
                          onChanged: (text) {
                            _.agente.cliente.persona.apellidos = text;
                          },
                          validator: (value) {
                            if (value == null || value.length == 0)
                              return 'Este campo es requerido';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        Focus(
                          onFocusChange: (value) {
                            print("Focus $value");
                          },
                          child: InputWidget(
                            editable: _.agente.cliente.idcliente == 0,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                  mask: '####-##-##',
                                  filter: {"#": RegExp(r'[0-9]')})
                            ],
                            label: 'Fecha de nacimiento (AAAA-MM-DD)',
                            placeHolder: 'AAAA-MM-DD',
                            fontSize: responsive.dp(1.8),
                            // error: _.error2.value,
                            keyboardType: TextInputType.number,
                            valor:
                                _.agente.cliente.persona.fechanaciemiento ?? '',
                            onChanged: (text) {
                              _.agente.cliente.persona.fechanaciemiento = text;
                            },
                            validator: (value) {
                              if (value == null || value.length == 0)
                                return 'Este campo es requerido';

                              try {
                                DateTime fecha =
                                    new DateFormat("yyyy-MM-dd").parse(value);

                                int age = Utils.calculateAge(fecha);

                                if (age < 18)
                                  return 'El cliente debe ser mayor de edad';
                                if (age > 99) return 'Fecha no valida';
                              } catch (e) {
                                return 'Fecha invalida';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(0.5),
                        ),
                        InputSelectWidget(
                          editable: _.agente.cliente.idcliente == 0,
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
                          editable: _.agente.cliente.idcliente == 0,
                          valor: _.agente.cliente.persona.telefono1 ?? '',
                          label: 'Telefono/Celular',
                          onChanged: (text) {
                            _.agente.cliente.persona.telefono1 = text;
                          },
                          validator: (value) {
                            if (value == null || value.length == 0)
                              return 'Este campo es requerido';
                            return null;
                          },
                        )
                      ],
                    ),
                  )));
  }
}

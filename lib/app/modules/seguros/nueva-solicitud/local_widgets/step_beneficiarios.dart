import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/helpers/upper_case_text_formatter.dart';
import 'package:fupa_aliados/app/helpers/utils.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../nueva_solicitud_seguros_controller.dart';

class StepBeneficiariosView extends StatelessWidget {
  final int index;

  const StepBeneficiariosView({Key key, @required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudSegurosController>(
        builder: (_) => Container(
                child: Form(
              //   key: _.form2Key,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Container(
                        width: responsive.wp(25),
                        child: InputSelectWidget(
                          value: _.tipodoc,
                          fontSize: responsive.dp(1.8),
                          label: '',
                          options: ['CI', 'RUC', 'DNI', 'PASS'],
                          onChanged: (text) {
                            _.tipodoc = text;
                          },
                        ),
                      ),
                      Expanded(
                        child: Focus(
                          onFocusChange: (focus) async {
                            print("Focus $focus");
                            print(_.agente.beneficiarios[index].persona.nrodoc
                                .length);
                            if (!focus &&
                                _.agente.beneficiarios[index].persona.nrodoc
                                        .length >
                                    5) {
                              _.agente.beneficiarios[index].persona =
                                  await _.buscarPersona(
                                      doc: _.doc, tipodoc: _.tipodoc);
                              _.update();
                            }
                          },
                          child: InputWidget(
                            label: 'Numero de documento',
                            valor: _.agente.beneficiarios[index].persona.nrodoc,
                            keyboardType: TextInputType.number,
                            fontSize: responsive.dp(1.8),
                            validator: (value) {
                              if (value == null || value.length == 0)
                                return 'El documento es requerido';
                              return null;
                            },
                            onChanged: (text) {
                              _.doc = text;
                              _.agente.beneficiarios[index].persona.nrodoc =
                                  text;
                              print(
                                  _.agente.beneficiarios[index].persona.nrodoc);
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: responsive.wp(15),
                        margin: EdgeInsets.only(left: responsive.wp(1)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondaryColor,
                        ),
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () async {
                              _.agente.beneficiarios[index].persona =
                                  await _.buscarPersona(
                                      doc: _.doc, tipodoc: _.tipodoc);
                              _.update();
                            },
                            icon: Icon(FontAwesomeIcons.search)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(0.5),
                  ),
                  InputWidget(
                    focusNode: _.nameFocus,
                    label: 'Nombres',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],

                    fontSize: responsive.dp(1.8),
                    editable:
                        _.agente.beneficiarios[index].persona.idpersona == 0,
                    // error: _.error2.value,
                    valor: _.agente.beneficiarios[index].persona.nombres ?? '',
                    onChanged: (text) {
                      _.agente.beneficiarios[index].persona.nombres = text;
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
                    editable:
                        _.agente.beneficiarios[index].persona.idpersona == 0,
                    label: 'Apellidos',
                    fontSize: responsive.dp(1.8),
                    // error: _.error2.value,
                    valor:
                        _.agente.beneficiarios[index].persona.apellidos ?? '',
                    onChanged: (text) {
                      _.agente.beneficiarios[index].persona.apellidos = text;
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
                      editable:
                          _.agente.beneficiarios[index].persona.idpersona == 0,
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')})
                      ],
                      label: 'Fecha de nacimiento (AAAA-MM-DD)',
                      placeHolder: 'AAAA-MM-DD',
                      fontSize: responsive.dp(1.8),
                      // error: _.error2.value,
                      keyboardType: TextInputType.number,
                      valor: _.agente.beneficiarios[index].persona
                              .fechanaciemiento ??
                          '',
                      onChanged: (text) {
                        _.agente.beneficiarios[index].persona.fechanaciemiento =
                            text;
                      },
                      validator: (value) {
                        if (value == null || value.length == 0)
                          return 'Este campo es requerido';

                        try {
                          DateTime fecha =
                              new DateFormat("yyyy-MM-dd").parse(value);

                          int age = Utils.calculateAge(fecha);

                          if (index == 1) {
                            if (age < 18)
                              return 'El cliente debe ser mayor de edad';
                            if (age > 75) return 'Edad no válido';
                          } else {
                            if (age > 21)
                              return 'El beneficiario debe ser hasta 21 años';
                          }
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
                  Row(
                    children: [
                      Expanded(
                        child: InputSelectWidget(
                          editable:
                              _.agente.beneficiarios[index].persona.idpersona ==
                                  0,
                          // value: _.tipodoc,
                          value:
                              _.agente.cliente.persona.tipopersona ?? 'FISICA',
                          fontSize: responsive.dp(1.8),
                          label: 'Tipo persona',
                          options: ['FISICA', 'JURIDICA'],
                          onChanged: (text) {
                            print(text);
                            _.agente.cliente.persona.tipopersona = text;
                          },
                        ),
                      ),
                      SizedBox(
                        width: responsive.hp(0.5),
                      ),
                      Container(
                        width: responsive.wp(35),
                        child: InputSelectWidget(
                          editable:
                              _.agente.beneficiarios[index].persona.idpersona ==
                                  0,
                          value: _.agente.cliente.persona.sexo ?? 'M',
                          fontSize: responsive.dp(1.8),
                          label: 'Sexo',
                          options: ['M', 'F'],
                          onChanged: (text) {
                            print(text);
                            _.agente.cliente.persona.sexo = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: responsive.hp(0.3)),
                    child: Center(
                        child: Text(
                      '* Adjunte 2 (dos) imagenes',
                      style: TextStyle(color: Colors.green.shade700),
                    )),
                  ),
                  MaterialButton(
                    elevation: 5.0,
                    color: Colors.blueGrey.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    onPressed: () async {
                      final origen = await _.dialogSelectOrigen();
                      print(origen);
                      if (origen != null && origen > 0) {
                        _.adjuntarCIBeneficiario(origen, index);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: responsive.hp(6),
                      color: Colors.transparent,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.addressCard,
                              color: Colors.white,
                            ),
                            Text(
                              '   ADJUNTAR CI',
                              style: AppFonts.secondaryFont.copyWith(
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontSize: responsive.dp(1.5),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.hp(1)),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceAround,
                    children: _.agente.beneficiarios[index].filesList
                        .map((e) => Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(e.path),
                                    width: responsive.wp(30),
                                    height: responsive.hp(15),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: SafeArea(
                                      child: CupertinoButton(
                                        color: Colors.black38,
                                        padding: EdgeInsets.all(1),
                                        borderRadius: BorderRadius.circular(30),
                                        child: Icon(
                                          FontAwesomeIcons.times,
                                          size: responsive.dp(2.5),
                                        ),
                                        onPressed: () {
                                          _.agente.beneficiarios[index]
                                              .filesList
                                              .remove(e);
                                          _.update();
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            )));
  }
}

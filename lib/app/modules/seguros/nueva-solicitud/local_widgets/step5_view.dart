import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';

import '../nueva_solicitud_seguros_controller.dart';

class Step5View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudSegurosController>(
        builder: (_) => Card(
                child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.user,
                    color: AppColors.secondaryColor,
                  ),
                  title: Text(
                    "${_.agente.cliente.persona.nombres} ${_.agente.cliente.persona.apellidos}",
                    style: AppFonts.primaryFont.copyWith(
                        fontSize: responsive.dp(1.7),
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text("Titular"),
                ),
                lineSeparator(),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.shieldAlt,
                    color: AppColors.secondaryColor,
                  ),
                  title: Text(
                    "${_.agente.tiposeguro}",
                    style: AppFonts.primaryFont.copyWith(
                        fontSize: responsive.dp(1.7),
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text("Tipo de seguro"),
                ),
                lineSeparator(),
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.handHoldingUsd,
                    color: AppColors.secondaryColor,
                  ),
                  title: RichText(
                    text: TextSpan(
                        text: "Monto del crédito: ",
                        style: AppFonts.primaryFont.copyWith(
                            fontSize: responsive.dp(1.7),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: _.agente.tiposeguro == 'INDIVIDUAL'
                                  ? "G 240.000"
                                  : '1.080.000',
                              style: AppFonts.secondaryFont.copyWith(
                                  fontSize: responsive.dp(1.7),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                  ),
                  subtitle: Text("Plazo de 12 meses."),
                ),
                lineSeparator(),
                if (_.agente.tiposeguro == 'FAMILIAR')
                  ..._beneficiarios(context, _)
              ],
            )));
  }

  List<Widget> _beneficiarios(
    BuildContext context,
    NuevaSolicitudSegurosController _,
  ) {
    final responsive = Responsive.of(Get.context);
    List<Widget> list = [];

    list.add(Container(
        margin: EdgeInsets.only(
          top: 25,
          left: 15,
        ),
        child: Center(
          child: Text("Beneficiarios",
              style: AppFonts.primaryFont.copyWith(
                  fontSize: responsive.dp(1.8),
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold)),
        )));

    print('Cantidad de beneficiarios: ${_.agente.beneficiarios.length}');

    _.agente.beneficiarios.forEach((e) {
      if (e.persona.nrodoc != null &&
          e.persona.nombres != null &&
          e.persona.apellidos != null) {
        list.add(ListTile(
          leading: Icon(
            FontAwesomeIcons.userFriends,
            color: AppColors.secondaryColor,
          ),
          title: Text(
            "${e.persona.nombres} ${e.persona.apellidos}",
            style: AppFonts.primaryFont.copyWith(
                fontSize: responsive.dp(1.65),
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(e.idparentezco == 1 ? "Cónyuge" : "Hijo/a"),
        ));
        list.add(lineSeparator());
      }
    });

    return list;
  }
}

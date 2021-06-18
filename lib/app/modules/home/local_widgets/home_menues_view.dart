import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/modules/home/local_widgets/menu_button_widget.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';

class HomeMenuesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          MenuButtonWidget(
              icon: FontAwesomeIcons.handHoldingUsd,
              text: 'Procesar crédito',
              route: AppRoutes.SOLICITAR_CREDITO),
          MenuButtonWidget(
              icon: FontAwesomeIcons.folder,
              text: 'Reportes',
              route: AppRoutes.REPORTE_TOTALES),
        ]),
      ],
    );
  }
}

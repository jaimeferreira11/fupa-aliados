import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/modules/home/local_widgets/menu_button_widget.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';

class HomeMenuesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Cache.instance.user.tipobeneficiario == 100
        ? _menuFranquicia()
        : Cache.instance.user.tipobeneficiario == 300
            ? _menuAgentes()
            : Cache.instance.user.tipobeneficiario == 400
                ? _menuSeguros()
                : Container();
  }

  Widget _menuFranquicia() {
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
        ])
      ],
    );
  }

  Widget _menuAgentes() {
    return Table(
      children: [
        TableRow(children: [
          MenuButtonWidget(
              vertical: false,
              icon: FontAwesomeIcons.plus,
              text: 'Nueva solicitud',
              descripcion: 'Registre una nueva solicitud',
              route: AppRoutes.NUEVA_SOLICITUD),
        ]),
        TableRow(children: [
          MenuButtonWidget(
              vertical: false,
              icon: FontAwesomeIcons.externalLinkAlt,
              text: 'Solicitudes realizadas',
              descripcion: "Últimas solicitudes realizadas",
              route: AppRoutes.SOLICITUDES_AGENTE),
        ]),
        TableRow(children: [
          MenuButtonWidget(
              vertical: false,
              icon: FontAwesomeIcons.check,
              text: 'Reporte totales',
              descripcion: "Operaciones realizadas con éxito",
              route: AppRoutes.REPORTE_AGENTE),
        ])
      ],
    );
  }

  Widget _menuSeguros() {
    return Table(
      children: [
        TableRow(children: [
          MenuButtonWidget(
              vertical: false,
              icon: FontAwesomeIcons.plus,
              text: 'Nueva solicitud',
              descripcion: 'Registre una nueva solicitud',
              route: AppRoutes.NUEVA_SOLICITUD_SEGUROS),
        ]),
        TableRow(children: [
          MenuButtonWidget(
              vertical: false,
              icon: FontAwesomeIcons.externalLinkAlt,
              text: 'Solicitudes realizadas',
              descripcion: "Últimas solicitudes realizadas",
              route: AppRoutes.SOLICITUDES_SEGUROS),
        ]),
        TableRow(children: [
          MenuButtonWidget(
              vertical: false,
              icon: FontAwesomeIcons.check,
              text: 'Reporte totales',
              descripcion: "Operaciones realizadas con éxito",
              route: AppRoutes.REPORTE_SEGUROS),
        ])
      ],
    );
  }
}

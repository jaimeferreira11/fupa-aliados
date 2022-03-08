import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';

import '../nueva_solicitud_seguros_controller.dart';

class Step4View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudSegurosController>(
        builder: (_) => GetBuilder<NuevaSolicitudSegurosController>(
            id: 'tipo-seguro',
            builder: (_) => ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    _CardTipo(
                      title: "Individual",
                      condicion: 'G. 20.000 \n x 12 meses',
                    ),
                    _CardTipo(
                      title: "Familiar",
                      subtitle:
                          'Cobertura titular, cónyuge y hasta 3 hijos menores a 21 años',
                      condicion: 'G. 90.000 \n x 12 meses',
                    ),
                    _CardTipo(
                      title: "Multiventajas",
                      condicion: 'G. 77.000 \n x 12 meses',
                    ),
                  ],
                )));
  }
}

class _CardTipo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String condicion;

  const _CardTipo(
      {Key key,
      @required this.title,
      this.subtitle = 'Cobertura titular',
      @required this.condicion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NuevaSolicitudSegurosController>(
      builder: (_) {
        return Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Radio(
              value: title.toUpperCase(),
              groupValue: _.agente.tiposeguro,
              onChanged: (value) {
                _.agente.tiposeguro = value;
                _.agente.monto = 1080000;
                _.update(['tipo-seguro']);
              },
              activeColor: Colors.green,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            trailing: Text(
              condicion,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.accentColor, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}

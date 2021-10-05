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
                    Card(
                      child: ListTile(
                        title: Text("Indiviual"),
                        subtitle: Text("Cobertura titular"),
                        leading: Radio(
                          value: "INDIVIDUAL",
                          groupValue: _.agente.tiposeguro,
                          onChanged: (value) {
                            _.agente.tiposeguro = value;
                            _.agente.monto = 240000;
                            _.update(['tipo-seguro']);
                          },
                          activeColor: Colors.green,
                        ),
                        trailing: Text(
                          'G. 20.000 \n x 12 meses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w500),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text("Familiar"),
                        subtitle: Text(
                            'Cobertura titular, cónyuge y hasta 3 hijos menores a 21 años'),
                        leading: Radio(
                          value: "FAMILIAR",
                          groupValue: _.agente.tiposeguro,
                          onChanged: (value) {
                            _.agente.tiposeguro = value;
                            _.agente.monto = 1080000;
                            _.update(['tipo-seguro']);
                          },
                          activeColor: Colors.green,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        trailing: Text(
                          'G. 90.000 \n x 12 meses',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                )));
  }
}

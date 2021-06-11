import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/reporte_totales_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ReporteTotalesPage extends StatelessWidget {
  const ReporteTotalesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ReporteTotalesController>(
          builder: (_) => SafeArea(
                child: Scaffold(
                  appBar: AppBar(title: Text('Solicitar credito')),
                  body: Container(),
                ),
              )),
    );
  }
}

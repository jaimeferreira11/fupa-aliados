import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/solicitar_credito_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';

class SearchHeaderWidget extends GetView<SolicitarCreditoController> {
  @override
  Widget build(BuildContext context) {
    final Color colorBlanco = Colors.white.withOpacity(0.7);
    final responsive = Responsive.of(context);
    return Stack(
      children: <Widget>[
        _SearchHeaderBackground(),
        Positioned(
            top: -40,
            left: -70,
            child: FaIcon(FontAwesomeIcons.search,
                size: responsive.dp(30), color: Colors.white.withOpacity(0.1))),
        Column(
          children: <Widget>[
            SizedBox(height: responsive.hp(2), width: double.infinity),
            Text("Buscar cliente",
                style: TextStyle(
                    fontSize: responsive.dp(2.2),
                    color: colorBlanco,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: responsive.hp(1.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: responsive.wp(30),
                  child: GetBuilder<SolicitarCreditoController>(
                    id: 'tipoDoc',
                    builder: (_) {
                      return InputSelectWidget(
                        value: controller.tipodoc,
                        label: 'Tipo documento',
                        options: ['CI', 'RUC', 'DNI', 'PASS'],
                        onChanged: (text) {
                          print(text);
                          controller.tipodoc = text;
                          controller.update(['tipoDoc']);
                        },
                      );
                    },
                  ),
                ),

                Obx(() => Container(
                      width: responsive.wp(60),
                      child: InputWidget(
                          label: 'Documento cliente',
                          valor: controller.doc,
                          error: controller.error.value,
                          onChanged: (valor) {
                            controller.doc = valor;
                          }),
                    )),

                // FaIcon(FontAwesomeIcons.times, size: 30, color: Colors.white),
              ],
            ),
            SizedBox(height: responsive.hp(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    controller.comprobarDisponibilidad();
                  },
                  color: Colors.white.withOpacity(.4),
                  shape: StadiumBorder(),
                  child: Container(
                    width: responsive.wp(20),
                    padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                    child: Center(
                      child: controller.workInProgress
                          ? CircularProgressIndicator()
                          : FaIcon(FontAwesomeIcons.search,
                              size: responsive.dp(3), color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: responsive.wp(5)),
                MaterialButton(
                  onPressed: () {
                    controller.doc = "";
                    controller.reset();
                  },
                  color: Colors.red.withOpacity(.7),
                  shape: StadiumBorder(),
                  child: Container(
                    width: responsive.wp(20),
                    padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.eraser,
                          size: responsive.dp(3), color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.hp(2)),
            Text(
                controller.cliente == null
                    ? "No encontrado"
                    : "Cliente encontrado",
                style: TextStyle(
                    fontSize: responsive.dp(2),
                    color: colorBlanco,
                    fontWeight: FontWeight.w200)),
            SizedBox(height: responsive.hp(.5)),
            Container(
              padding: EdgeInsets.only(
                  left: responsive.wp(6), right: responsive.wp(3)),
              child: Text(
                  controller.cliente == null
                      ? ''
                      : '${controller.cliente.persona.nrodoc} - ${controller.cliente.persona.nombres} ${controller.cliente.persona.apellidos}'
                          .capitalize,
                  style: TextStyle(
                      fontSize: responsive.dp(2.2),
                      color: colorBlanco,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        )
      ],
    );
  }
}

class _SearchHeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GetBuilder<SolicitarCreditoController>(
      id: 'fondo',
      builder: (_) {
        return AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          width: double.infinity,
          height: _.height,
          decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    AppColors.primaryColor,
                    AppColors.darkColor,
                  ])),
        );
      },
    );
  }
}

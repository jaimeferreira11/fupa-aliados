import 'package:animate_do/animate_do.dart';
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
    return _SearchHeaderBackground();
  }
}

class _SearchHeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color colorBlanco = Colors.white.withOpacity(0.7);
    final responsive = Responsive.of(context);
    return GetBuilder<SolicitarCreditoController>(
      id: 'fondo',
      builder: (_) {
        return BounceInDown(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            width: double.infinity,

            // height: _.height,
            decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(80)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      AppColors.primaryColor,
                      AppColors.darkColor,
                    ])),
            child: Stack(
              children: [
                Positioned(
                    top: -25,
                    left: -50,
                    child: FaIcon(FontAwesomeIcons.search,
                        size: responsive.dp(27),
                        color: Colors.white.withOpacity(0.1))),
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
                                value: _.tipodoc,
                                label: 'Tipo documento',
                                options: ['CI', 'RUC', 'DNI', 'PASS'],
                                onChanged: (text) {
                                  print(text);
                                  _.tipodoc = text;
                                  _.update(['tipoDoc']);
                                },
                              );
                            },
                          ),
                        ),

                        Obx(() => Container(
                              width: responsive.wp(60),
                              child: InputWidget(
                                  label: 'Documento cliente',
                                  valor: _.doc,
                                  error: _.error.value,
                                  onChanged: (valor) {
                                    _.doc = valor;
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
                            _.comprobarDisponibilidad();
                          },
                          color: Colors.white.withOpacity(.4),
                          shape: StadiumBorder(),
                          child: Container(
                            width: responsive.wp(20),
                            padding: EdgeInsets.symmetric(
                                vertical: responsive.hp(1)),
                            child: Center(
                              child: _.workInProgress
                                  ? CircularProgressIndicator()
                                  : FaIcon(FontAwesomeIcons.search,
                                      size: responsive.dp(3),
                                      color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: responsive.wp(5)),
                        MaterialButton(
                          onPressed: () {
                            _.doc = "";
                            _.reset();
                          },
                          color: Colors.red.withOpacity(.7),
                          shape: StadiumBorder(),
                          child: Container(
                            width: responsive.wp(20),
                            padding: EdgeInsets.symmetric(
                                vertical: responsive.hp(1)),
                            child: Center(
                              child: FaIcon(FontAwesomeIcons.eraser,
                                  size: responsive.dp(3), color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: responsive.hp(2)),
                    Visibility(
                      visible: _.busquedaRealizada,
                      child: Text(
                          _.cliente == null
                              ? "No encontrado"
                              : "Cliente encontrado",
                          style: TextStyle(
                              fontSize: responsive.dp(2),
                              color: colorBlanco,
                              fontWeight: FontWeight.w200)),
                    ),
                    Visibility(
                      visible: _.busquedaRealizada,
                      child: Container(
                        margin: EdgeInsets.only(top: responsive.hp(.5)),
                        padding: EdgeInsets.only(
                            bottom: responsive.hp(2),
                            left: responsive.wp(7),
                            right: responsive.wp(4)),
                        child: Text(
                            _.cliente == null
                                ? ''
                                : '${_.cliente.persona.nrodoc}\n ${_.cliente.persona.nombres} ${_.cliente.persona.apellidos}'
                                    .capitalize,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: responsive.dp(2.1),
                                color: colorBlanco,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:intl/intl.dart';

class AboutAppView extends StatelessWidget {
  final anio = DateFormat('yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.white,
            child: Center(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 25.0),
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Text(
                      "Desarrollada por",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(1.8),
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: responsive.hp(1)),
                    height: responsive.hp(10),
                    color: Colors.white,
                    child: SvgPicture.asset(
                      "assets/images/logo_fupa.svg",
                      color: Color(0xff558a51),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: responsive.hp(2)),
                    color: Colors.white,
                    child: Text(
                      "© $anio Fundación Paraguaya de Cooperación y Desarrollo",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(1.8),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: responsive.hp(1)),
                    color: Colors.white,
                    child: Text(
                      "Todos los derechos reservados",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(1.7),
                        fontWeight: FontWeight.w200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: responsive.hp(4.5)),
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: responsive.hp(13),
                          child: Image.asset('assets/images/burt.jpg'),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: responsive.hp(6),
                                margin: EdgeInsets.only(left: responsive.wp(6)),
                                child:
                                    Image.asset('assets/images/burt_firma.png'),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0, left: 15.0),
                                child: Text(
                                  "Martín Burt",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: responsive.dp(2),
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Director Ejecutivo',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.dp(1.8),
                                      fontWeight: FontWeight.w100,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 45.0),
                    color: AppColors.primaryColor,
                    child: Text(
                      "DESARROLLADO POR",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(1.8),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: responsive.hp(2.5),
                    ),
                    color: Colors.white,
                    child: Text(
                      "Jaime Ferreira",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: responsive.hp(0.5),
                    ),
                    color: Colors.white,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Desarrollador Senior',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.dp(1.8),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w100,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: '',
                              style: TextStyle(fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: responsive.hp(5),
                    ),
                    color: Colors.white,
                    child: Text(
                      "Departamento de tecnología",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: responsive.hp(2),
                    ),
                    color: Colors.white,
                    child: MaterialButton(
                      onPressed: () {
                        showAboutDialog(
                          context: context,
                          applicationIcon: Container(
                            height: 50.0,
                            child: Image.asset("assets/images/ic_launcher.png"),
                          ),
                          applicationName: 'Aliados FP',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2021 Fundación Paraguaya',
                          children: <Widget>[],
                        );
                      },
                      child: Text(
                        "Más información",
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: responsive.dp(2),
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

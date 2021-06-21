import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:open_appstore/open_appstore.dart';

class NewVersionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    var textStyleAudiencia2 = TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w700,
      fontSize: responsive.dp(2.5),
    );

    var textStyleLightButton = AppFonts.secondaryFont.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: responsive.dp(2),
    );

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30, left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        ClipOval(
                          child: Container(
                              //  color: Colors.white,
                              height: responsive.hp(20),
                              child:
                                  Image.asset('assets/images/ic_launcher.png')
                              /* SvgPicture.asset(
                                  'assets/images/beneficios/cine/sinfunciones.svg'),*/
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  color: Colors.transparent,
                  child: Material(
                    child: Text(
                      "Estás utilizando una versión antigua. Actualice la aplicación desde aquí",
                      style: textStyleAudiencia2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                MaterialButton(
                  elevation: 5.0,
                  color: AppColors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () async {
                    OpenAppstore.launch(
                        androidAppId: "py.org.fundacionparaguaya.aliados",
                        iOSAppId: "1573264570");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50.0,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Actualizar",
                          style: textStyleLightButton,
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
          Visibility(
            visible: false,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fupa_aliados/app/globlas_widgets/buscando_progress_w.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/pin_code/pin_code_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodePage extends StatelessWidget {
  const PinCodePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GetBuilder<PinCodeController>(
      builder: (_) => WillPopScope(
        onWillPop: () async {
          await _.atras();
          return true;
        },
        child: Stack(
          children: [
            Scaffold(
              key: _.scaffoldKey,
              backgroundColor: Colors.white,
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: responsive.hp(4)),
                          Container(
                              height: MediaQuery.of(context).size.height / 3.5,
                              child: Image(
                                  image:
                                      AssetImage("assets/images/intro2.png"))),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: responsive.hp(1)),
                            child: Text(
                              'Código de verificación',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.dp(3)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(5),
                                vertical: responsive.hp(.5)),
                            child: RichText(
                              text: TextSpan(
                                  text: "Ingrese el código enviado al ",
                                  children: [
                                    TextSpan(
                                        text: _.celular,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: responsive.dp(1.8))),
                                  ],
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: responsive.dp(1.8))),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 5, top: 5),
                            child: RichText(
                              text: TextSpan(
                                  text:
                                      "Si no tenés este número, favor comunicate con atención al cliente",
                                  children: [],
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: responsive.dp(1.8))),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _.formKey,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: responsive.hp(1.5),
                                    horizontal: responsive.wp(6)),
                                child: PinCodeTextField(
                                  appContext: context,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 4,
                                  animationType: AnimationType.fade,
                                  validator: (v) {
                                    if (v.length < 4) {
                                      return "Ingrese 4 digitos";
                                    } else {
                                      return null;
                                    }
                                  },
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.underline,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 60,
                                    fieldWidth: 50,
                                    activeFillColor: _.hasError != null
                                        ? Colors.orange
                                        : Colors.white,
                                  ),
                                  cursorColor: Colors.black,
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  textStyle: TextStyle(
                                      fontSize: responsive.dp(2.4),
                                      height: 1.6),

                                  errorAnimationController: _.errorController,
                                  controller: _.textEditingController,
                                  keyboardType: TextInputType.number,

                                  onCompleted: (v) {
                                    print("Completed");
                                  },
                                  // onTap: () {
                                  //   print("Pressed");
                                  // },
                                  onChanged: (value) {
                                    print(value);

                                    _.currentText = value;
                                    _.update();
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    return true;
                                  },
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              _.currentText.length < 4
                                  ? "* Ingrese el código de 4 caracteres"
                                  : _.hasError ?? "",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: responsive.hp(2)),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "¿No recibiste el código? ",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: responsive.dp(1.8)),
                                children: [
                                  TextSpan(
                                      text: " Reenviar",
                                      recognizer:
                                          _.reenviar ? null : _.onTapRecognizer,
                                      style: TextStyle(
                                          color: _.reenviar
                                              ? Colors.grey
                                              : AppColors.darkColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: responsive.dp(2.1)))
                                ]),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: responsive.hp(3)),
                            alignment: Alignment.center,
                            child: widgetBoton(_),
                          ),
                          SizedBox(
                            height: responsive.hp(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MaterialButton(
                                child: Text("Limpiar campos"),
                                onPressed: () {
                                  _.textEditingController.clear();
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 10,
                      child: SafeArea(
                        child: CupertinoButton(
                          color: Colors.black26,
                          padding: EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(30),
                          child: Icon(Icons.arrow_back),
                          onPressed: () async {
                            await _.atras();
                            return true;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BuscandoProgressWidget(buscando: _.buscando)
          ],
        ),
      ),
    );
  }

  Widget widgetBoton(PinCodeController _) {
    var textStyleLightButton = AppFonts.secondaryFont.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );

    if (_.workInProgress) {
      return Container(
        height: 50.0,
        child: MaterialButton(
          onPressed: null,
          child: SpinKitWave(
            color: AppColors.primaryColor,
            type: SpinKitWaveType.end,
            size: 24.0,
          ),
        ),
      );
    } else {
      return MaterialButton(
        elevation: 5.0,
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          _.formKey.currentState.validate();

          // conditions for validating
          if (_.currentText.length != 4) {
            _.errorController.add(
                ErrorAnimationType.shake); // Triggering error shake animation

          } else {
            _.validarSolicitud();
          }
        },
        child: Container(
          width: Get.size.width * 0.8,
          height: 50.0,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Validar",
                style: textStyleLightButton,
              ),
            ],
          ),
        ),
      );
    }
  }
}

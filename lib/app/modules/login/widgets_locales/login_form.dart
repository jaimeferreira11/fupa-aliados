import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/send_form_button_w.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../login_controller.dart';

class LoginForm extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final form = controller.loginForm;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ReactiveForm(
        formGroup: form,
        child: Container(
          width: responsive.wp(90),
          margin: EdgeInsets.only(top: responsive.hp(4)),
          padding: EdgeInsets.symmetric(
              vertical: responsive.hp(3), horizontal: responsive.wp(5)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0, 1.0),
                spreadRadius: 1.5,
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: responsive.hp(1),
              ),
              Text(
                'Ingrese sus credenciales',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.dp(2.2),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: responsive.hp(3.5),
              ),
              Container(
                child: _InputWidget(
                  controlName: 'user',
                  hintText: 'Usuario',
                  icon: FontAwesomeIcons.userAlt,
                  validationMessageRequired: 'Este campo es obligatorio',
                  suffixIcon: false,
                  obscureText: false,
                ),
              ),
              SizedBox(
                height: responsive.hp(3.5),
              ),
              Container(
                child: Obx(
                  () => _InputWidget(
                    controlName: 'password',
                    hintText: 'Contraseña',
                    obscureText: true,
                    icon: FontAwesomeIcons.lock,
                    validationMessageRequired: 'Este campo es obligatorio',
                    suffixIcon: true,
                    suffixIcon1: controller.mostrarPassword
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    controller: controller,
                  ),
                ),
              ),
              SizedBox(height: responsive.hp(3)),
              Container(
                width: double.infinity,
                child: new Material(
                  child: new InkWell(
                    onTap: () {
                      controller.recoveryPassword();
                    },
                    child: Text(
                      "Se me olvidó mi contraseña",
                      textAlign: TextAlign.right,
                      style: AppFonts.secondaryFont.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: responsive.dp(2),
                          color: Colors.blue.shade700),
                    ),
                  ),
                  color: Colors.transparent,
                ),
              ),
              SizedBox(
                height: responsive.hp(4.0),
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return Obx(
                    () => IgnorePointer(
                      ignoring: controller.ignore.value,
                      child: FormularioSendButton(
                        text: "Ingresar",
                        loginController: controller,
                        form: form,
                        funcion: controller.login,
                        width: double.infinity,
                        height: responsive.hp(7),
                        ignore: controller.ignore,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: responsive.hp(3),
              ),
              lineSeparator(),
              SizedBox(
                height: responsive.hp(3),
              ),
              Wrap(children: [
                Text(
                  '¿No tenés usuario?',
                  style: TextStyle(
                      fontSize: responsive.dp(2),
                      fontWeight: FontWeight.w400,
                      color: Colors.black87),
                ),
                SizedBox(width: responsive.wp(3)),
                GestureDetector(
                  onTap: () => controller.nav.goTo(AppRoutes.REGISTER),
                  child: Text(
                    'Registrate',
                    style: AppFonts.secondaryFont.copyWith(
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputWidget extends StatelessWidget {
  const _InputWidget({
    @required this.controlName,
    @required this.validationMessageRequired,
    @required this.icon,
    @required this.hintText,
    @required this.suffixIcon,
    this.suffixIcon1,
    this.controller,
    this.obscureText,
  });

  final String controlName;
  final String validationMessageRequired;
  final String hintText;
  final IconData icon;
  final bool suffixIcon;
  final bool obscureText;
  final IconData suffixIcon1;
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return ReactiveTextField(
      formControlName: controlName,
      obscureText: obscureText ? controller.mostrarPassword : false,
      validationMessages: (_) => {
        ValidationMessage.required: validationMessageRequired,
      },
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        prefixIcon: Icon(
          icon,
          color: AppColors.secondaryColor,
          size: responsive.dp(2.5),
        ),
        hintText: "Escribe aquí",
        labelStyle: TextStyle(color: Colors.blueGrey),
        hintStyle:
            TextStyle(color: Colors.black26, fontStyle: FontStyle.italic),
        labelText: hintText,
        suffixIcon: suffixIcon
            ? IconButton(
                icon: FaIcon(suffixIcon1, color: AppColors.inputColor),
                onPressed: controller.cambiarMostrarPassword,
              )
            : null,
      ),
      style: TextStyle(fontSize: responsive.dp(2)),
    );
  }
}

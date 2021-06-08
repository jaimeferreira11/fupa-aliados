import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/send_form_button_w.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../register_controller.dart';

class RegisterForm extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final form = controller.loginForm;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ReactiveForm(
        formGroup: form,
        child: Container(
          width: responsive.wp(85),
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
              Hero(
                tag: 'login',
                child: Container(
                  margin: EdgeInsets.only(bottom: responsive.hp(2)),
                  child: Image(
                    image: AssetImage('assets/images/logo_fupa.jpeg'),
                    height: responsive.hp(8),
                  ),
                ),
              ),
              Text(
                'Ingrese sus datos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.dp(2),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: responsive.hp(3),
              ),
              Container(
                child: _InputWidget(
                  controlName: 'user',
                  hintText: 'Nombre',
                  icon: FontAwesomeIcons.userAlt,
                  validationMessageRequired: 'Este campo es obligatorio',
                  suffixIcon: false,
                  obscureText: false,
                ),
              ),
              SizedBox(height: responsive.hp(2)),
              Container(
                child: _InputWidget(
                  controlName: 'correo',
                  hintText: 'Correo',
                  icon: FontAwesomeIcons.at,
                  validationMessageRequired: 'Este campo es obligatorio',
                  suffixIcon: false,
                  obscureText: false,
                ),
              ),
              SizedBox(height: responsive.hp(2)),
              Container(
                child: _InputWidget(
                  controlName: 'correo',
                  hintText: 'Contacto',
                  icon: FontAwesomeIcons.mobileAlt,
                  validationMessageRequired: 'Este campo es obligatorio',
                  suffixIcon: false,
                  obscureText: false,
                ),
              ),
              SizedBox(height: responsive.hp(2)),
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
              SizedBox(
                height: responsive.hp(3.0),
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) {
                  return Obx(
                    () => IgnorePointer(
                      ignoring: controller.ignore.value,
                      child: FormularioSendButton(
                        text: "Registrarme",
                        registerController: controller,
                        form: form,
                        funcion: controller.login,
                        width: double.infinity,
                        height: 50,
                        ignore: controller.ignore,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: responsive.hp(3.0),
              ),
              lineSeparator(),
              SizedBox(
                height: responsive.hp(3.0),
              ),
              Wrap(children: [
                Text(
                  'Ya tenés usuario?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => controller.nav.goToOff(AppRoutes.LOGIN),
                  child: Text(
                    'Ingresá',
                    style: AppFonts.secondaryFont.copyWith(
                        fontSize: 18,
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
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: controlName,
      obscureText: obscureText ? controller.mostrarPassword : false,
      validationMessages: (_) => {
        ValidationMessage.required: validationMessageRequired,
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        icon: FaIcon(
          icon,
          color: AppColors.secondaryColor,
          size: 20,
        ),
        hintText: hintText,
        labelText: hintText,
        suffixIcon: suffixIcon
            ? IconButton(
                icon: FaIcon(suffixIcon1),
                onPressed: controller.cambiarMostrarPassword,
              )
            : null,
      ),
      style: TextStyle(fontSize: 18),
    );
  }
}

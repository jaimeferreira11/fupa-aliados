import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/login/login_controller.dart';
import 'package:fupa_aliados/app/modules/register/register_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FormularioSendButton extends StatelessWidget {
  const FormularioSendButton({
    this.loginController,
    @required this.form,
    @required this.funcion,
    @required this.height,
    @required this.width,
    @required this.ignore,
    this.registerController,
    //this.profileController,
    @required this.text,
  });

  final LoginController loginController;
  final RegisterController registerController;
  //final ProfileController profileController;
  final FormGroup form;
  final Function funcion;
  final double height;
  final double width;
  final RxBool ignore;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
          elevation: 5.0,
          color: form.valid
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.5),
          shape: StadiumBorder(),
          child: _LoginButtonChild(
            controller: loginController,
            ignore: ignore,
            text: text,
          ),
          onPressed: form.valid ? funcion : () {}),
    );
  }
}

class _LoginButtonChild extends StatelessWidget {
  const _LoginButtonChild(
      {@required this.controller, @required this.ignore, @required this.text});

  final LoginController controller;
  final RxBool ignore;
  final String text;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: Obx(
        () => ignore.value
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(
                text,
                style: AppFonts.secondaryFont
                    .copyWith(color: Colors.white, fontSize: responsive.dp(2)),
              ),
      ),
    );
  }
}

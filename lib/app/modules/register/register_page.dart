import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/login/widgets_locales/login_form.dart';
import 'package:fupa_aliados/app/modules/register/widgets_locales/register_form.dart';
import 'package:fupa_aliados/app/routes/app_routes.dart';
import 'package:get/get.dart';

import 'register_controller.dart';
import 'widgets_locales/bg_register.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GetBuilder<RegisterController>(
        builder: (_) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey[400],
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      BackgroundLogin3(),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Hero(
                          tag: 'martin',
                          child: Image.asset(
                            'assets/images/logo_MB.png',
                            height: responsive.hp(10),
                          ),
                        ),
                      )),
                      Positioned.fill(
                          child: Container(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: RegisterForm()),
                      )),
                    ],
                  ),
                ),
              ),
            ));
  }
}

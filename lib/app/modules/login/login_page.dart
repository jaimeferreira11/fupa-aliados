import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/login/widgets_locales/login_form.dart';
import 'package:get/get.dart';

import 'login_controller.dart';
import 'widgets_locales/bg_login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GetBuilder<LoginController>(
        builder: (_) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey[200],
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      BackgroundLogin3(),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Hero(
                                tag: 'login',
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: responsive.hp(3),
                                      bottom: responsive.hp(.5)),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/logo_blanco.png'),
                                    height: responsive.hp(10),
                                  ),
                                ),
                              ),
                              FadeInDown(
                                  child: Center(
                                child: Text(
                                  'Aliados',
                                  style: TextStyle(
                                      fontFamily: "Candara",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: responsive.dp(4)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                          child: Align(
                              alignment: Alignment.center, child: LoginForm())),
                      Positioned.fill(
                          child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Hero(
                          tag: 'martin',
                          child: Image.asset(
                            'assets/images/logo_MB.png',
                            height: responsive.hp(10),
                            width: double.infinity,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ));
  }
}

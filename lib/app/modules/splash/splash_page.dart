import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/modules/splash/splash_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'local_widgets/loader_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<SplashController>(
          builder: (_) => SafeArea(
                child: Scaffold(
                  body: LoaderLogo(),
                ),
              )),
    );
  }
}

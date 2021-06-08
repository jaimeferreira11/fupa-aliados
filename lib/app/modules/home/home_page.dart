import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/modules/home/home_controller.dart';
import 'package:fupa_aliados/app/modules/home/local_widgets/drawer_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'local_widgets/home_menues_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(
          builder: (_) => SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(_.title),
                    actions: [
                      IconButton(
                          onPressed: () => _.launchDialogCerrarSesion(),
                          icon: Icon(Icons.exit_to_app))
                    ],
                  ),
                  drawer: DrawerView(),
                  backgroundColor: Colors.grey[200],
                  body: _.selectedView,
                ),
              )),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          // Card Table
          HomeMenuesView(),
        ],
      ),
    );
  }
}

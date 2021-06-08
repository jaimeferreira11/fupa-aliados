import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class BuscandoProgressWidget extends StatelessWidget {
  final RxBool buscando;

  BuscandoProgressWidget({@required this.buscando});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Obx(
        () {
          if (buscando.value) return Center(child: CircularProgressIndicator());
          return Container();
        },
      ),
    );
  }
}

import 'package:get/get.dart';

import 'reporte_agente_controller.dart';

class ReporteAgenteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteAgenteController());
  }
}

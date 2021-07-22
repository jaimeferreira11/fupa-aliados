import 'package:get/get.dart';

import 'solicitudes_agente_controller.dart';

class SolicitudesAgenteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SolicitudesAgenteController());
  }
}

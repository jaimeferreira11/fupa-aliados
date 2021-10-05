import 'package:get/get.dart';

import 'solicitudes_seguros_controller.dart';

class SolicitudesSegurosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SolicitudesSegurosController());
  }
}

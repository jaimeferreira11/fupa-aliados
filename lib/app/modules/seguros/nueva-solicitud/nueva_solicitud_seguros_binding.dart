import 'package:get/get.dart';

import 'nueva_solicitud_seguros_controller.dart';

class NuevaSolicitudSegurosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NuevaSolicitudSegurosController());
  }
}

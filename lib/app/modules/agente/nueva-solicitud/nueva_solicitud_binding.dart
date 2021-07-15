import 'package:get/get.dart';

import 'nueva_solicitud_controller.dart';

class NuevaSolicitudBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NuevaSolicitudController());
  }
}

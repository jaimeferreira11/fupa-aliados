import 'package:get/get.dart';

import 'reporte_seguros_controller.dart';

class ReporteSegurosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteSegurosController());
  }
}

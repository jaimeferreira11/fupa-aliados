import 'package:fupa_aliados/app/modules/pin_code/pin_code_controller.dart';
import 'package:get/get.dart';

class PinCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinCodeController());
  }
}

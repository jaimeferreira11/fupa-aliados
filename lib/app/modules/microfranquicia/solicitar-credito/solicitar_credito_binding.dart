import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/solicitar_credito_controller.dart';
//import 'package:fupa_aliados/app/modules/pin_code/pin_code_controller.dart';
import 'package:get/get.dart';

class SolicitarCreditoBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(PinCodeController());
    Get.lazyPut(() => SolicitarCreditoController());
  }
}

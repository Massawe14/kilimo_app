import 'package:get/get.dart';
import 'package:kilimo_app/util/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}

import 'package:demo_mobile_assignment/controllers/demo_controller.dart';
import 'package:get/instance_manager.dart';

class DemoBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoController>(() => DemoController());
  }
}

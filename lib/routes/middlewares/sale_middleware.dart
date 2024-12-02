import 'package:demo_mobile_assignment/controllers/demo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DemoMiddleware extends GetMiddleware {
  @override
  Widget onPageBuilt(Widget page) {
    Get.find<DemoController>().init();
    return super.onPageBuilt(page);
  }
}

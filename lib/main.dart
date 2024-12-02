import 'package:demo_mobile_assignment/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) => GetMaterialApp(
              getPages: Pages.routes,
              defaultTransition: Transition.native,
              initialRoute: Routes.splashScreen,
            ));
  }
}

import 'package:demo_mobile_assignment/routes/bindings/demo_binding.dart';
import 'package:demo_mobile_assignment/routes/middlewares/sale_middleware.dart';
import 'package:demo_mobile_assignment/screens/demo.dart';
import 'package:demo_mobile_assignment/screens/splash_screen.dart';
import 'package:get/get.dart';

class Routes {
  Routes._();
  static const String splashScreen = '/';
  static const String demoScreen = '/demo';
}

class Pages {
  Pages._();
  static final List<GetPage> routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
        name: Routes.demoScreen,
        page: () => DemoScreen(),
        binding: DemoBind(),
        middlewares: [DemoMiddleware()]),
  ];
}

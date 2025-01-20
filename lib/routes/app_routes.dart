import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/splash/binding/splash_binding.dart';
import 'package:probcell_solutions/presentation/splash/splash_screen.dart';


class Routes {
  static const splash = '/splash';
    }

class RoutesPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}

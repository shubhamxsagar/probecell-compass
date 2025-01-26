import 'package:get/get.dart';
import 'package:probcell_solutions/presentation/login/login_binding.dart';
import 'package:probcell_solutions/presentation/login/login_screen.dart';
import 'package:probcell_solutions/presentation/splash/binding/splash_binding.dart';
import 'package:probcell_solutions/presentation/splash/splash_screen.dart';


class Routes {
  static const splash = '/splash';
  static const login = '/login';
    }

class RoutesPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}

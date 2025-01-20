import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:probcell_solutions/core/constants/local_string.dart';
import 'package:probcell_solutions/core/services/api_client.dart';
import 'package:probcell_solutions/core/services/shared_pref_service.dart';
import 'package:probcell_solutions/routes/app_routes.dart';

import 'core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => PrefUtils().init());
  await Get.putAsync(() => ApiClient().init());
  await Get.putAsync(() => AuthService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CreditSea Connect',
      initialRoute: RoutesPages.initial,
      getPages: RoutesPages.routes,
      // initialBinding: NetworkBinding(),
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
          useMaterial3: true,
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Colors.yellow,
            selectionHandleColor: Colors.transparent,
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
//import 'package:greengrocery/src/pages/auth/view/singInScreen.dart';
//import 'package:greengrocery/src/pages/splash/splash_screen.dart';
import 'package:greengrocery/src/pages_routes/app_pages.dart';

void main() {
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quitanda',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      //home: const SplashScreen(),
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
      //SingInScreen(),
    );
  }
}

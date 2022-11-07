import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/pages/auth/view/singInScreen.dart';
import 'package:greengrocery/src/pages/home/titulo_formatado.dart';
import 'package:greengrocery/src/pages_routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(PagesRoutes.singInRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              CustomColors.customSwacthColor.shade700,
              CustomColors.customSwacthColor.shade500,
              CustomColors.customSwacthColor.shade300,
              CustomColors.customSwacthColor.shade100,
            ])),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TituloFormatado(
              greenTitleColor: Colors.white,
              textSize: 40.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

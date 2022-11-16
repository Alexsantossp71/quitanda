import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';

import 'package:greengrocery/src/pages/home/view/components/titulo_formatado.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().validateToken();
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
            const SizedBox(
              height: 20.0,
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

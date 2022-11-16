import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocery/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:greengrocery/src/pages/comom_widgets/custom_text_field.dart';

import 'package:greengrocery/src/pages/home/titulo_formatado.dart';
import 'package:greengrocery/src/pages_routes/app_pages.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final utilsService = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(children: [
            //nome do app
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // nome do app

                TituloFormatado(
                  greenTitleColor: Colors.white,
                  textSize: 40.0,
                ),
                // categorias
                SizedBox(
                  height: 35,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      pause: Duration.zero,
                      animatedTexts: [
                        FadeAnimatedText("Frutas"),
                        FadeAnimatedText("Verduras"),
                        FadeAnimatedText("Cereais"),
                        FadeAnimatedText("Laticinios"),
                        FadeAnimatedText("Carnes"),
                        FadeAnimatedText("Pães"),
                        FadeAnimatedText("Bolos"),
                      ],
                    ),
                  ),
                ),
              ],
            )),
            // FORMULÁRIO
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 40,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(45),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // e-mail
                    CustomTextField(
                      controller: emailController,
                      icon: Icons.email,
                      label: "E-mail",
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Digite seu e-mail';
                        }
                        ;
                        if (!email.isEmail) {
                          return 'Digite um e-mail valido';
                        }
                        ;

                        return null;
                      },
                    ),
                    //senha
                    CustomTextField(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: "Senha",
                      isSecret: true,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Digite sua senha';
                        }
                        if (password.length < 7) {
                          return 'Digite uma senha com pelo menos 7 caracteres';
                        }
                        return null;
                      },
                    ),
                    // entrar
                    SizedBox(
                      height: 50,
                      child: GetX<AuthController>(
                        builder: (authController) {
                          return ElevatedButton(
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      String email = emailController.text;
                                      String password = passwordController.text;
                                      authController.signIn(
                                          email: email, password: password);
                                      //  Get.offNamed(PagesRoutes.baseRoute);
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator(
                                    // color: Colors.white,
                                    )
                                : const Text(
                                    "Entrar",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          );
                        },
                      ),
                    ),
                    // esqueceu senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_) {
                                return ForgotPasswordDialog(
                                    email: emailController.text);
                              },
                            );
                            Focus.of(context).unfocus();
                            print(result);
                            if (result!) {
                              utilsService.showToast(
                                  message:
                                      'Um link de recuperação foi enviado ao seu e-mail');
                            } else {
                              utilsService.showToast(message: 'caiu no else');
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          )),
                    ),
                    // divisor
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'ou',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey.withAlpha(90),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // novo usuario
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.green,
                            )),
                        onPressed: () {
                          //
                          //Navigator.of(context).push(MaterialPageRoute(builder:(c){ return SingUpScreen();}));
                          Get.toNamed(PagesRoutes.singUpRoute);
                        },
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

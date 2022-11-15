// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocery/src/pages/comom_widgets/custom_text_field.dart';
import 'package:greengrocery/src/services/validators.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SingUpScreen extends StatelessWidget {
  SingUpScreen({Key? key}) : super(key: key);

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );
  final telefoneFormatter = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(children: [
                  const Expanded(
                    child: Center(
                      child: Expanded(
                        child: Center(
                          child: Text(
                            "CADASTRO",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // formulário

                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          label: 'E-mail',
                          icon: Icons.email,
                          textInputType: TextInputType.emailAddress,
                          validator: emailValidator,
                          onSaved: (value) {
                            authController.user.email = value;
                          },
                        ),
                        CustomTextField(
                          label: 'Senha',
                          icon: Icons.lock,
                          validator: passwordValidator,
                          isSecret: true,
                          onSaved: (value) {
                            authController.user.password = value;
                          },
                        ),
                        CustomTextField(
                          label: 'Nome',
                          icon: Icons.person,
                          validator: nameValidator,
                          onSaved: (value) {
                            authController.user.name = value;
                          },
                        ),
                        CustomTextField(
                            label: 'Telefone',
                            icon: Icons.phone,
                            textInputType: TextInputType.phone,
                            validator: phoneValidator,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            inputFormatters: [telefoneFormatter]),
                        CustomTextField(
                          label: 'CPF',
                          icon: Icons.file_copy,
                          textInputType: TextInputType.number,
                          validator: cpfValidator,
                          onSaved: (value) {
                            authController.user.cpf = value;
                          },
                          inputFormatters: [cpfFormatter],
                        ),
                        SizedBox(
                          height: 50,
                          child: Obx(() {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        authController.signUp();
                                      }
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      // color: Colors.white,
                                      )
                                  : const Text(
                                      'Cadastrar usuário',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

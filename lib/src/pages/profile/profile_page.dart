import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocery/src/pages/comom_widgets/custom_text_field.dart';
import 'package:greengrocery/src/config/responsive_layout.dart';
import 'package:greengrocery/src/models/app_data.dart' as appData;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ResponsiveLayout.constrained(
        maxWidth: 600,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          children: [
            CustomTextField(
              initialValue: appData.user.email,
              readOnly: true,
              label: 'E-mail',
              icon: Icons.email,
            ),
            CustomTextField(
              initialValue: appData.user.name,
              readOnly: true,
              label: 'Nome',
              icon: Icons.person,
            ),
            CustomTextField(
              initialValue: appData.user.phone,
              readOnly: true,
              label: 'Telefone',
              icon: Icons.phone,
            ),
            CustomTextField(
              initialValue: appData.user.cpf,
              readOnly: true,
              label: 'CPF',
              icon: Icons.file_copy,
              isSecret: true,
            ),
            SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () {
                  updatePassword();
                },
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.green,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: const Text('Alterar Senha'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualizar Senha',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock,
                        label: 'Senha atual',
                      ),
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: 'Nova Senha',
                      ),
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: 'Confirmar',
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          child: const Text('Confirmar'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ))
              ],
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:greengrocery/src/pages/comom_widgets/custom_text_field.dart';
import 'package:greengrocery/src/models/app_data.dart' as appData;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //email
          CustomTextField(
            initialValue: appData.user.email,
            readOnly: true,
            label: 'E-mail',
            icon: Icons.email,
          ),
          //nome
          CustomTextField(
            initialValue: appData.user.name,
            readOnly: true,
            label: 'Nome',
            icon: Icons.person,
          ),
          //telefone
          CustomTextField(
            initialValue: appData.user.phone,
            readOnly: true,
            label: 'Telefone',
            icon: Icons.phone,
          ),
          //cpf
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
              child: Text('Alterar Senha'),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.green,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Stack(
              children: [
                // cointeudo dialog
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // titulo
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualizar Senha',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      //senha atual
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock,
                        label: 'Senha atual',
                      ),
                      //senha nova
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: 'Nova Senha',
                      ),
                      //confirma senha
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: 'Confirmar',
                      ),
                      // botão confirmar

                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (){},
                            child: Text ('Confirmar'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                            )
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                // icone de fechar
                Positioned(
                  top: 10,
                   right: 10,
                    child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close), )
                )
              ],
            ),
          );
        });
  }
}

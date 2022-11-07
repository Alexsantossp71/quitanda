import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greengrocery/src/pages/comom_widgets/custom_text_field.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SingUpScreen extends StatelessWidget {
 SingUpScreen({Key? key}) : super(key: key);

 final cpfFormatter = MaskTextInputFormatter(
   mask: '###.###.###-##',
   filter: { '#' : RegExp(r'[0-9]')},
 );
 final telefoneFormatter = MaskTextInputFormatter(
   mask: '(##)#####-####',
   filter: { '#' : RegExp(r'[0-9]')},
 );

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
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                ),
              ),
              Column(
                children: [
                  Expanded(

                    child: Center(
                      child: const   Expanded(
                          child: Center(
                            child: Text("CADASTRO",
                        style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),),
                          ),
                        ),
                    ),
                  ),

                  // formulário

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                      ),
                    child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(label: 'E-mail', icon: Icons.email,),
                          CustomTextField(label: 'Senha', icon: Icons.lock, isSecret: true,),
                          CustomTextField(label: 'Nome', icon: Icons.person,),
                          CustomTextField(label: 'Telefone', icon: Icons.phone,inputFormatters: [telefoneFormatter]),
                          CustomTextField(label: 'CPF', icon: Icons.file_copy, inputFormatters: [cpfFormatter],),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ) ),
                                  onPressed: (){},
                              child: Text('Cadastrar usuário', style: TextStyle(fontSize: 18, color: Colors.white),),

                            ),
                            ),

                        ],
                      ),
                    ),

                ]

              ),
            ],
          ),
        ),
      ),
    );
  }
}

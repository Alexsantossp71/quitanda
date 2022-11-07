import 'package:flutter/material.dart';
import 'package:greengrocery/src/config/custom_colors.dart';

class OrderStatusWiget extends StatelessWidget {
  final String status;
  final bool isOverdue;


  final Map<String, int> allStatus = <String, int>{
    'pending_payment':0,
    'refunded':1,
    'pay':2,
    'preparing_purchase':3,
    'shipping':4,
    'delivered':5,
  };

  int get currentStatus => allStatus[status]!;

   OrderStatusWiget({Key? key, required this.status, required this.isOverdue})
      : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        //DOT PERMANENTE DE PEDIDO CONFIRMADO
        const _StatusDot(
          isActive: true,
          title: 'Pedido Confirmado',

        ),
        const _CustomDivider(),

        // LÓGICA DE VERIFICAÇÃO DO STATUS
        // TESTA SE O PIX FOI ESTORNADO
        if ( currentStatus == 1 )...[
               const _StatusDot(
                isActive: true,
                title: 'Pix estornado.',
                backgroundColor: Colors.orange,
              ),
        ]
        //TESTA SE O PEDIDO VENCEU  - NÃO DEPOSITOU A TEMPO
        else if (isOverdue)...[
           const _StatusDot(
           backgroundColor: Colors.red,
              isActive: true,
              title: 'Pagamento Pix vencido.'),
          ]
        // DEPOSITOU EM TEMPO O PIX NÃO FOI ESTORNADO COMEÇA A JORNADA DE ENVIO
        else...[
             _StatusDot(

              isActive: currentStatus >=2,
              title: 'Pagamento',

            ),
            const _CustomDivider(),
             _StatusDot(
              isActive:currentStatus >=3,
              title: 'Preparando',

            ),
            const _CustomDivider(),
             _StatusDot(
              isActive: currentStatus >=4,
              title: 'Envio',

            ),
            const _CustomDivider(),
             _StatusDot(
              isActive: currentStatus >=5,
              title: 'Entregue',

            ),


    ]

      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      height: 10,
      width: 2,
      color: Colors.grey,
    );
  }
}


class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String title;
  final Color? backgroundColor;
   const _StatusDot({Key? key, this.backgroundColor, required this.isActive, required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        //DOT
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          child: isActive ?  const Icon(Icons.check, size: 13, color: Colors.white,) : const SizedBox.shrink(),
          decoration: BoxDecoration(
            color:
                isActive
                    ? backgroundColor
                ?? CustomColors.customSwacthColor : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwacthColor,
            ),
          ),
        ),

        //ESPAÇO
        const SizedBox(width: 5,),

        // TEXTO STATUS DO PEDIDO
  Expanded(child: Text(title , style: const TextStyle(
    fontSize: 12,
  ),),)
      ],
    );
  }
}

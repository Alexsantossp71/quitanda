

import 'package:flutter/material.dart';
import 'package:greengrocery/src/models/orders_model.dart';
import 'package:greengrocery/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  PaymentDialog({Key? key, required this.order}) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: Alignment.center,
        children: [
         // conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //TITULO
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text('Pagamento com Pix',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                // QR CODE
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: QrImage(
                    data: '12345',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),

                // VENCIMENTO
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                      'Vencimento : ${utilsServices.formatDateTime(order.overdueDateTime)}',
                      style: const TextStyle(fontSize: 12)),
                ),

                // TOTAL

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text('Total : ${utilsServices.priceToCurrency(order.total)}',
                      style:
                          const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
                // BOTÃO COPIA E COLA

                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.copy, size: 15,
                    ),
                    label: const Text(
                      'Copiar código Pix',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )),

                //
              ],
            ),
          ),
          //botão fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ))
        ],
      ),
    );
  }
}

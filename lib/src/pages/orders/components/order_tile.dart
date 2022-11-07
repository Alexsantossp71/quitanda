import 'package:flutter/material.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/models/orders_model.dart';
import 'package:greengrocery/src/models/app_data.dart' as appData;
import 'package:greengrocery/src/pages/orders/components/order_status_widget.dart';
import 'package:greengrocery/src/services/utils_services.dart';

import '../../comom_widgets/payment_dialog.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  OrderTile({Key? key, required this.order}) : super(key: key);

  final UtilsServices utilServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          initiallyExpanded: order.status == 'pending_payment' ? true : false,
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.id,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.customSwacthColor,
                ),
              ),
              Text(
                utilServices.formatDateTime(order.createdDateTime),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          children: [
            SizedBox(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    // EXPANDED LADO DA LISTA DOS ITENS
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 150,
                            child: ListView(
                              children: order.items.map((orderItem) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${orderItem.quantity} ${orderItem.item.unit} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(orderItem.item.itemName),
                                      ),
                                      Text(utilServices.priceToCurrency(
                                          orderItem.totalPrice()))
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // DIVISOR

                    VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                      width: 8,
                    ),

                    // EXPANDED DO LADO DO STATUS DO PEDIDO
                    Expanded(
                      flex: 2,
                      child: OrderStatusWiget(
                        status: order.status,
                        isOverdue:
                            order.overdueDateTime.isBefore(DateTime.now()),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // total
            Text.rich(TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Total : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: utilServices.priceToCurrency(order.total),
                  ),
                ])),

            // BOTÃO DE PAGAMENTO
            Visibility(
              visible: order.status == 'pending_payment',
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return PaymentDialog(
                        order: order,
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                )),
                icon: Image.asset(
                  'assets/app_images/pix.png',
                  height: 18,
                ),
                label: const Text('Ver QR Code do Pix'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

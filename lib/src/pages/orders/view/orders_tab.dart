import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/pages/orders/controller/all_orders_controler.dart';
import 'package:greengrocery/src/pages/orders/view/components/order_tile.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersControler>(
        builder: (controller) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.allOrders.length,
            separatorBuilder: (_, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (_, index) => OrderTile(
              order: controller.allOrders[index],
            ),
          );
        },
      ),
    );
  }
}

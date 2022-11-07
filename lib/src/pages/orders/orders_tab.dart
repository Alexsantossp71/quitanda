import 'package:flutter/material.dart';
import 'package:greengrocery/src/models/app_data.dart' as appData;
import 'package:greengrocery/src/pages/orders/components/order_tile.dart';

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

      body: ListView.separated(
        padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          itemCount: appData.orders.length,
          separatorBuilder: (_, index) => const SizedBox(height: 10,),
          itemBuilder: (_,index) => OrderTile(order: appData.orders[index], ),
      ),
    );
  }
}

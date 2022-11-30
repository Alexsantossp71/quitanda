import 'package:flutter/material.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
//import 'package:greengrocery/src/models/app_data.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocery/src/pages/comom_widgets/quantity_widget.dart';
import 'package:greengrocery/src/services/utils_services.dart';
import 'package:get/get.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;
  final Function(int) updatedQuantity;
  CartTile({
    Key? key,
    required this.cartItem,
    required this.updatedQuantity,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // IMAGEM
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        // NOME
        title: Text(
          widget.cartItem.item.itemName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        //TOTAL DO ITEM
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CustomColors.customSwacthColor,
          ),
        ),
        // BOTÃO DE QUANTIDADE
        trailing: QuantityWidget(
          suffixText: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          result: (quantity) {
            controller.changeItemQuantity(
                item: widget.cartItem, quantity: quantity);
          },
          isRemovable: true,
        ),
      ),
    );
  }
}

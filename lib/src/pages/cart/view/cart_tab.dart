import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocery/src/pages/cart/view/components/cart_tile.dart';
import 'package:greengrocery/src/pages/comom_widgets/payment_dialog.dart';
import 'package:greengrocery/src/services/utils_services.dart';
import 'package:greengrocery/src/models/app_data.dart' as appData;

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  double cartTotalPrice() {
    //double total = 0;
    /*  for (var item in appData.cartItems) {
      total += item.totalPrice();
    }
    return total;*/
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body:
          // LISTA DE ITENS DO CARRINHO
          Column(children: [
        Expanded(
          child: GetBuilder<CartController>(
            builder: (controller) {
              if (controller.cartItems.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart,
                      size: 40,
                      color: CustomColors.customSwacthColor,
                    ),
                    const Text('Não há itens no carrinho.'),
                  ],
                );
              }

              return ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (_, index) {
                  return CartTile(
                    cartItem: controller.cartItems[index],
                    updatedQuantity: (qtd) {
                      // Chamando nosso novo atributo que é uma função que recebe a quantidade
                      /* if (qtd == 0) {
                        removeItemFromCart(controller.cartItems[
                            index]); // Removendo do carrinho passando o item do carrinho que o nosso ItemBuilder fornece
                      } else {
                        setState(() => cartItem.quantity =
                            qtd); // Atualizando a quantidade do produto
                      }*/
                    },
                  );
                },
              );
            },
          ),
        ),

        // TOTAL DO CARRINHO
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                " Preço Total :",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      // '12',
                      utilsServices
                          .priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        color: CustomColors.customSwacthColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: controller.isCheckoutLoading
                          ? null
                          : () async {
                              // CHAMA O DIALOG DE CONFIRMAÇÃO
                              bool? result = await showOrderConfirmation();

                              if (result ?? false) {
                                cartController.checkoutCart();
                              } else {
                                utilsServices.showToast(
                                    message: 'Pedido não confirmado',
                                    isError: true);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          primary: CustomColors.customSwacthColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      child: controller.isCheckoutLoading
                          ? const CircularProgressIndicator()
                          : const Text('Concluir Pedido'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente concluir o pedido?'),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Não')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Sim'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }
}

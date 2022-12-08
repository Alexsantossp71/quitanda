import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocery/src/pages/product/product_screen.dart';
import 'package:greengrocery/src/pages_routes/app_pages.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class ItemTile extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile({
    Key? key,
    required this.item,
    required this.cartAnimationMethod,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();

  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  IconData tileIcon = Icons.add_shopping_cart_outlined; //Icons.check;

  Future<void> switchIcon() async {
    setState(
      () => tileIcon = Icons.check,
    );
    // print('ESTOU DENTRO DO SWITCH');
    await Future.delayed(const Duration(seconds: 3));
    setState(
      () => tileIcon = Icons.add_shopping_cart_outlined,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CARD COM OS DADOS DO PRODUTO
        Card(
          elevation: 3,
          shadowColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          // CARD COM DADOS DO PRODUTO
          child: GestureDetector(
            onTap: () {
              Get.toNamed(PagesRoutes.productRoute, arguments: widget.item);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //IMAGEM
                  Expanded(
                    child: Hero(
                      tag: widget.item.imgUrl,
                      child: Container(
                        child: Image.network(
                          widget.item.imgUrl,
                        ),
                        key: imageGk,
                      ),
                    ),
                  ),
                  // NOME
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  // PREÇO - UNIDADE
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.customSwacthColor),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        // CONTAINER DO CARRINHO
        //BOTÃO DE ADICIONAR ITENS AO CARRINHO
        Positioned(
            top: 4,
            right: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(20),
              ),
              child: Material(
                child: InkWell(
                  onTap: () {
                    // print('CLICOU PARA O CARRINHO');
                    switchIcon();
                    cartController.addItemToCart(item: widget.item);

                    widget.cartAnimationMethod(imageGk);
                  },
                  child: Ink(
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      color: CustomColors.customSwacthColor,
                    ),
                    child: Icon(
                      // Icons.shopping_cart_outlined,
                      tileIcon,

                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

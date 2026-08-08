import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/config/responsive_layout.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocery/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocery/src/pages/comom_widgets/quantity_widget.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    super.key,
  });

  final ItemModel item = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartItemQuantity = 1;

  final navigationController = Get.find<NavigationController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          ResponsiveLayout.constrained(
            maxWidth: 600,
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                      tag: widget.item.imgUrl,
                      child: Image.network(
                        widget.item.imgUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.green.shade50,
                          child: const Icon(
                            Icons.broken_image_outlined,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.item.itemName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 27),
                              ),
                            ),
                            QuantityWidget(
                              suffixText: widget.item.unit,
                              value: cartItemQuantity,
                              result: (int quantity) {
                                setState(() {
                                  cartItemQuantity = quantity;
                                });
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            utilsServices.priceToCurrency(widget.item.price),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                color: CustomColors.customSwacthColor),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SingleChildScrollView(
                              child: Text(
                                widget.item.description,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    height: 1.5, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.back();
                                cartController.addItemToCart(
                                    item: widget.item,
                                    quantity: cartItemQuantity);
                                navigationController
                                    .navigationPageView(NavigationTabs.cart);
                              },
                              label: const Text(
                                'Adicionar ao carrinho',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios))),
          ),
        ],
      ),
    );
  }
}

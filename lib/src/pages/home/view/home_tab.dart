import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/config/custom_colors.dart';
import 'package:greengrocery/src/models/app_data.dart' as appData;
import 'package:greengrocery/src/pages/comom_widgets/custom_shimmer.dart';

import 'package:greengrocery/src/pages/home/view/components/category_tile.dart';
import 'package:greengrocery/src/pages/home/view/components/item_tile.dart';
import 'package:greengrocery/src/pages/home/controller/home_controller.dart';
import 'package:greengrocery/src/pages/home/view/components/titulo_formatado.dart';
import 'package:greengrocery/src/services/utils_services.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();
  final TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //APP BAR COM O TITULO - CARRINHO E BADGE

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: TituloFormatado(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              right: 15.0,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text('2'),
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwacthColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Column(
          children: [
            /////////////////////////////////////////////////////////
            // CAMPO DE PESQUISA
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return TextFormField(
                    controller: searchControler,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                      suffixIcon: controller.searchTitle.value.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchControler.clear();
                                controller.searchTitle.value = '';
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customContrastColor,
                                size: 21,
                              ))
                          : null,
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Pesquise aqui...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customContrastColor,
                        size: 25,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // LISTA CATEGORIAS
            GetBuilder<HomeController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return CategoryTile(
                              category: controller.allCategories[index].title,
                              onPressed: () {
                                controller.selectCategory(
                                    controller.allCategories[index]);
                              },
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: controller.allCategories.length)
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            10,
                            (index) => Container(
                              margin: EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: 25,
                                width: 80,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                ),
              );
            }),

            // GRID DE PRODUTOS
            GetBuilder<HomeController>(builder: (controller) {
              return Expanded(
                child: !controller.isProductLoading
                    ? Visibility(
                        visible: (controller.currentCategory?.items ?? [])
                            .isNotEmpty,
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 9 / 11.5,
                          ),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (_, index) {
                            if ((index + 1) == controller.allProducts.length &&
                                !controller.isLastPage) {
                              controller.loadMoreProducts();
                            }
                            return ItemTile(
                              item: controller.allProducts[index],
                              cartAnimationMethod: itemSelectedCartAnimations,
                            );
                          },
                        ),
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 40,
                              color: CustomColors.customSwacthColor,
                            ),
                            const Text('Não há produtos encontrados.'),
                          ],
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                          10,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}

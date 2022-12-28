import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocery/src/pages/cart/view/cart_tab.dart';
import 'package:greengrocery/src/pages/home/view/home_tab.dart';
import 'package:greengrocery/src/pages/orders/view/orders_tab.dart';
import 'package:greengrocery/src/pages/profile/profile_page.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfilePage(),
        ],
      ),

      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationController.currentIndex,
        onTap: (index) {
          navigationController.navigationPageView(index);
          // pageController.jumpToPage(index);
          /* pageController.animateToPage(index,
                duration: const Duration(milliseconds: 700),
                curve: Curves.ease);
          
          );
          */
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(60),
        backgroundColor: Colors.green.shade700,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

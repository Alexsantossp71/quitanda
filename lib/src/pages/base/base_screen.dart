import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocery/src/config/responsive_layout.dart';
import 'package:greengrocery/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocery/src/pages/cart/view/cart_tab.dart';
import 'package:greengrocery/src/pages/home/view/home_tab.dart';
import 'package:greengrocery/src/pages/orders/view/orders_tab.dart';
import 'package:greengrocery/src/pages/profile/profile_page.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    final bool desktop = ResponsiveLayout.isDesktop(context);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // NavigationRail for desktop / tablet
            if (desktop)
              NavigationRail(
                selectedIndex: navigationController.currentIndex,
                onDestinationSelected: (index) {
                  navigationController.navigationPageView(index);
                },
                labelType: NavigationRailLabelType.selected,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.shopping_cart_outlined),
                    selectedIcon: Icon(Icons.shopping_cart),
                    label: Text('Carrinho'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.list),
                    selectedIcon: Icon(Icons.list),
                    label: Text('Pedidos'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person_outlined),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Perfil'),
                  ),
                ],
                backgroundColor: Colors.green.shade700,
                selectedIconTheme: const IconThemeData(color: Colors.white),
                unselectedIconTheme: IconThemeData(color: Colors.white.withAlpha(120)),
                indicatorColor: Colors.white.withAlpha(50),
              ),

            // Page content
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: navigationController.pageController,
                children: const [
                  HomeTab(),
                  CartTab(),
                  OrdersTab(),
                  ProfilePage(),
                ],
              ),
            ),
          ],
        ),
      ),

      // BottomNavigationBar only for mobile
      bottomNavigationBar: desktop
          ? null
          : BottomNavigationBar(
              currentIndex: navigationController.currentIndex,
              onTap: (index) {
                navigationController.navigationPageView(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white.withAlpha(60),
              backgroundColor: Colors.green.shade700,
              selectedFontSize: 12,
              unselectedFontSize: 10,
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

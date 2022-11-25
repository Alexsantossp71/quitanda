import 'package:get/get.dart';
import 'package:greengrocery/src/pages/auth/view/singInScreen.dart';
import 'package:greengrocery/src/pages/auth/view/singUpScreen.dart';
import 'package:greengrocery/src/pages/base/base_screen.dart';
import 'package:greengrocery/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrocery/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocery/src/pages/cart/view/cart_tab.dart';
import 'package:greengrocery/src/pages/home/binding/home_biding.dart';
import 'package:greengrocery/src/pages/home/view/home_tab.dart';
import 'package:greengrocery/src/pages/orders/orders_tab.dart';
import 'package:greengrocery/src/pages/profile/profile_page.dart';
import 'package:greengrocery/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.singInRoute,
      page: () => SingInScreen(),
    ),
    GetPage(
      name: PagesRoutes.singUpRoute,
      page: () => SingUpScreen(),
    ),
    GetPage(
        name: PagesRoutes.baseRoute,
        page: () => const BaseScreen(),
        bindings: [
          NavigationBinding(),
          HomeBinding(),
          CartBinding(),
        ]),
    GetPage(
      name: PagesRoutes.homeRoute,
      page: () => const HomeTab(),
    ),
    GetPage(
      name: PagesRoutes.cartRoute,
      page: () => const CartTab(),
    ),
    GetPage(
      name: PagesRoutes.ordersRoute,
      page: () => const OrdersTab(),
    ),
    GetPage(
      name: PagesRoutes.profileRoute,
      page: () => const ProfilePage(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = '/splash';
  static const String singInRoute = '/signin';
  static const String singUpRoute = '/signup';
  static const String baseRoute = '/';
  static const String homeRoute = '/home';
  static const String cartRoute = '/cart';
  static const String ordersRoute = '/orders';
  static const String profileRoute = '/profile';
}

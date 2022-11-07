import 'package:get/get.dart';
import 'package:greengrocery/src/pages/auth/view/singInScreen.dart';
import 'package:greengrocery/src/pages/auth/view/singUpScreen.dart';
import 'package:greengrocery/src/pages/base/base_screen.dart';
import 'package:greengrocery/src/pages/cart/cart_tab.dart';
import 'package:greengrocery/src/pages/home/home_tab.dart';
import 'package:greengrocery/src/pages/orders/orders_tab.dart';
import 'package:greengrocery/src/pages/profile/profile_page.dart';
import 'package:greengrocery/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.splashRoute, page: () => SplashScreen()),
    GetPage(name: PagesRoutes.singInRoute, page: () => SingInScreen()),
    GetPage(name: PagesRoutes.singUpRoute, page: () => SingUpScreen()),
    GetPage(name: PagesRoutes.baseRoute, page: () => BaseScreen()),
    GetPage(name: PagesRoutes.homeRoute, page: () => HomeTab()),
    GetPage(name: PagesRoutes.cartRoute, page: () => CartTab()),
    GetPage(name: PagesRoutes.ordersRoute, page: () => OrdersTab()),
    GetPage(name: PagesRoutes.profileRoute, page: () => ProfilePage()),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_task/bloc/shop/shop_bloc.dart';
import 'package:last_task/ui/shop_screen/shop_screen.dart';
import 'package:last_task/ui/shop_screen/subscreen/add_product_screen.dart';
import 'package:last_task/ui/shop_screen/subscreen/all_product_screen.dart';
import 'package:last_task/ui/shop_screen/subscreen/get_product.dart';
import 'package:last_task/ui/splash/splash_screen.dart';


class RouteNames {
  static const String shop = "/shop";
  static const String splash = "/";
  static const String addProduct = "/add_product_screen";
  static const String getProduct = "/get_product_screen";
  static const String all = "/all_product_screen";

}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.shop:
        return MaterialPageRoute(builder: (context) => const ShopScreen());
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.addProduct:
        return MaterialPageRoute(builder: (context)=> AddProductScreen(text: settings.arguments as String));
      case RouteNames.all:
        return MaterialPageRoute(builder: (context)=>const AllProductScreen());
      case RouteNames.getProduct:
        return MaterialPageRoute(builder: (context) {
          return const GetProductScreen();
        });

      default:
        return MaterialPageRoute(
          builder: (context) =>const Scaffold(
            body: Center(child: Text('Route mavjud emas'),),
          ));
    }
  }
}

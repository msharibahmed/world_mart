import 'package:flutter/material.dart';
import 'package:world_mart/screens/auth_screen.dart';
import 'package:world_mart/screens/tsp_screen.dart';

import '../screens/developers_screen.dart';
import '../screens/manage_product_screen.dart';
import '../screens/order_screen.dart';
import '../screens/product_overview_screen.dart';

import 'drawerCard.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepOrange[300],
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                'assets/cart.png',
                width: 200,
              ),
              DrawerCard(
                  'Shop', Icons.shop_two, ProductOverviewScreen.routeName),
              DrawerCard(
                  'Orders', Icons.shopping_basket, OrderScreen.routeName),
              DrawerCard(
                  'Manage Product', Icons.shop, ManageProductScreen.routeName),
              DrawerCard('Developers', Icons.settings, DeveloperScreen.routeName),
              DrawerCard('TSP implemnetation', Icons.route_outlined, TspScreen.routeName),
              DrawerCard('Log Out', Icons.exit_to_app, AuthScreen.routeName),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
              DrawerCard('Shop', Icons.shop_two),
              DrawerCard('Orders', Icons.shopping_basket),
              DrawerCard('Manage Product', Icons.shop),
              DrawerCard('Settings', Icons.settings),
            ],
          ),
        ),
      ),
    );
  }
}

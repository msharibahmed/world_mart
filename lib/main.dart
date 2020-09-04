import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './provider/products.dart';
import './provider/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Products()),
          ChangeNotifierProvider(create: (context) => Cart()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              accentColor: Colors.orange,
              fontFamily: 'Lato'),
          home: ProductOverviewScreen(),
          routes: {
            ProductDetailScreen.namedroute: (context) => ProductDetailScreen()
          },
        ));
  }
}

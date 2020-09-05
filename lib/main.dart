import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/screens/cart_screen.dart';
import 'package:world_mart/widgets/badge.dart';
import 'package:world_mart/widgets/custom_drawer.dart';

import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './provider/products.dart';
import './provider/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    bool flip = false;
    AppBar appBar = AppBar(
      leading: Builder(
        builder: (context) {
          return Card(
            elevation: 10,
            color: Colors.deepOrange,
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => CustomDrawer.of(context).open(),
            ),
          );
        },
      ),
      title: Text('World Mart'),
      actions: [
        Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
                  value: cart.itemCount.toString(),
                  child: ch,
                ),
            child: Builder(
                builder: (BuildContext context) => Card(
                      elevation: 10,
                      shadowColor: Colors.black,
                      color: Colors.deepOrange,
                      child: IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                          }),
                    ))),
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          color: Colors.deepOrange,
          child: PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
              print(value);
            },
            icon: Icon(Icons.format_align_center),
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                  child: Text('Show All'), value: FilterOptions.ShowAll)
            ],
          ),
        )
      ],
    );
    Widget child =
        ProductOverviewScreen(appBar: appBar, favoriteOnly: _showFavoriteOnly);
    if (!flip) {
      child = CustomDrawer(child: child);
    }

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
          routes: {
            ProductOverviewScreen.routeName: (context) =>
                ProductOverviewScreen(),
            ProductDetailScreen.namedroute: (context) => ProductDetailScreen()
          },
          home: child),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/provider/major_project_products.dart';
import 'package:world_mart/screens/cart_screen.dart';
import 'package:world_mart/screens/developers_screen.dart';
import 'package:world_mart/screens/edit_product_screen.dart';
import 'package:world_mart/screens/splash_screen.dart';
import 'package:world_mart/widgets/badge.dart';
import 'package:world_mart/widgets/custom_drawer.dart';

import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './provider/products.dart';
import './provider/cart.dart';
import 'provider/auth.dart';
import 'provider/order.dart';
import 'screens/auth_screen.dart';
import 'screens/lru_cache_screen.dart';
import 'screens/manage_product_screen.dart';
import 'screens/order_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
                onPressed: () {
                  CustomDrawer.of(context).open();
                }),
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
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => MajorProducts()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: null,
            update: (context, auth, oldProducts) => Products(auth.token,
                oldProducts == null ? [] : oldProducts.items, auth.userId)),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Order>(
            create: null,
            update: (context, auth, oldOrder) => Order(auth.token, auth.userId,
                oldOrder == null ? [] : oldOrder.items)),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
                        .copyWith(secondary: Colors.orange)),
            routes: {
              ProductOverviewScreen.routeName: (_) => child,
              ManageProductScreen.routeName: (_) => ManageProductScreen(),
              AuthScreen.routeName: (_) => AuthScreen(),
              OrderScreen.routeName: (_) => OrderScreen(),
              ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
              EditProductScreen.routeName: (_) => EditProductScreen(),
              LRUCacheScreen.routeName: (_) => LRUCacheScreen(),
              DeveloperScreen.routeName: (_) => DeveloperScreen(),
            },
            // home: child
            home: auth.isAuth
                ? child
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapShot) =>
                        snapShot.connectionState == ConnectionState.waiting
                            ? Splashcreen()
                            : AuthScreen())),
      ),
    );
  }
}

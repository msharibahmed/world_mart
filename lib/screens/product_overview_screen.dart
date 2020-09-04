import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../provider/cart.dart';

enum FilterOptions { Favorites, ShowAll }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('World Mart'),
          actions: [
            Consumer<Cart>(
                builder: (context, cart, ch) => Badge(
                      value: cart.itemCount.toString(),
                      child: ch,
                    ),
                child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    })),
            PopupMenuButton(
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
            )
          ],
        ),
        body: ProductsGrid(_showFavoriteOnly));
  }
}

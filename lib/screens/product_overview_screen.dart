import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, ShowAll }

class ProductOverviewScreen extends StatelessWidget {
  static const routeName = 'product-overview';
  final AppBar appBar;
  final bool favoriteOnly;
  ProductOverviewScreen({this.appBar, this.favoriteOnly});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar, body: ProductsGrid(favoriteOnly));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_detail.dart';
import '../provider/products.dart';
import '../provider/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final productsData = products.findById(productId);

    void displaySnackBar(BuildContext ctx) {
      Scaffold.of(ctx).showSnackBar(cart.snackBar('Added To Cart!'));
    }

    return Scaffold(
      floatingActionButton: Builder(
          builder: (BuildContext ctx) => FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                cart.addItem(productId, productsData.title, productsData.price,
                    productsData.imageUrl);
                displaySnackBar(ctx);
              },
              child: Icon(Icons.add_shopping_cart, color: Colors.black))),
      appBar: AppBar(title: Text(productsData.title)),
      body: ProductDetail(productId),
    );
  }
}

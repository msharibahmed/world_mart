import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../provider/product.dart';
import '../provider/cart.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // final String id;
  // ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductDetailScreen.namedroute,
                    arguments: productData.id);
              },
              child: Image.network(productData.imageUrl, fit: BoxFit.cover)),
          footer: GridTileBar(
            leading: Consumer<Product>(
                builder: (context, product, _) => IconButton(
                    icon: Icon(
                      productData.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: productData.onFavoriteTap)),
            backgroundColor: Colors.black87,
            title: Text(
              productData.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.amber,
                ),
                onPressed: () {
                  cart.addItem(productData.id, productData.title,
  productData.price, productData.imageUrl);
                  print(cart.itemCount);
                }),
          )),
    );
  }
}

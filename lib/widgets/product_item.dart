import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../provider/product.dart';
import '../provider/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductDetailScreen.routeName,
                    arguments: productData.id);
              },
              child: Image.network(productData.imageUrl, fit: BoxFit.contain)),
          footer: GridTileBar(
            leading: Consumer<Product>(
                builder: (context, product, _) => IconButton(
                    icon: Icon(
                      productData.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      productData.onFavoriteTap();
                      
                      Scaffold.of(context).showSnackBar(cart.snackBar( productData.isFavorite
                                  ? 'Added To Favorites!'
                                  : 'Removed From Favorites!'));
                    })),
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
                  Scaffold.of(context).showSnackBar(
                  cart.snackBar('Added To Cart!'));
                }),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_detail.dart';
import '../provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const namedroute = 'product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final products = Provider.of<Products>(context,listen: false);
    final productsData = products.findById(productId);
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.amber,
          onPressed: () {}, child: Icon(Icons.add_shopping_cart,color:Colors.black)),
      appBar: AppBar(title: Text(productsData.title)),
      body: ProductDetail(productId),
    );
  }
}

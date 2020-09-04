import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class ProductDetail extends StatelessWidget {
  final String productId;

  ProductDetail(this.productId);
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final productsData = products.findById(productId);
    return Column(
      children: [
        Image.network(
          productsData.imageUrl,
          fit: BoxFit.cover,
          
        ),
      ],
    );
  }
}

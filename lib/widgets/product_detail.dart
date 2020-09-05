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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            productsData.imageUrl,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
          
          RichText(
              text: TextSpan(
                  children: [
                    
                TextSpan(
                    text: productsData.title[0],
                    style: TextStyle(
                        color: Colors.black,fontSize: 50, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: productsData.title.substring(1),
                    style: TextStyle(
                        color: Colors.black, fontSize: 35,fontWeight: FontWeight.w300)),
              ])),
                       Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Text(productsData.description,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  color: Colors.black87)),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          Text('\$' + productsData.price.toString() + '/Piece',
              style: TextStyle(fontSize: 25)),
        ],
      ),
    );
  }
}

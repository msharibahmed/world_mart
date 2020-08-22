import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String description;
  final String title;
  final double price;
  final bool isFavorite;

  ProductDetail(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.isFavorite});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Image.network(imageUrl,fit: BoxFit.cover,)],
    );
  }
}

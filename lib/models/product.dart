import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String imageUrl;
  final String title;
  final bool isFavorite;
  final double price;
  final description;

  Product(
      {@required this.id,
      @required this.imageUrl,
      @required this.title,
      @required this.description,
      this.isFavorite = false,
      @required this.price});
}

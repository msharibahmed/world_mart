import 'package:flutter/foundation.dart';

class Product extends ChangeNotifier {
  final String id;
  final String imageUrl;
  final String title;
  bool isFavorite;
  final double price;
  final description;

  Product(
      {@required this.id,
      @required this.imageUrl,
      @required this.title,
      @required this.description,
      this.isFavorite = false,
      @required this.price});
  void onFavoriteTap() {
    isFavorite = !isFavorite;
    notifyListeners();
    print(isFavorite);
  }
}

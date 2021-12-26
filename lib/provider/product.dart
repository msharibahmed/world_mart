import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
  Future<void> onFavoriteTap(Product prod,String authToken,String userId ) async {
    final uri =
        'https://world-cart-f1544.firebaseio.com/userFavorite/$userId/${prod.id}.json?auth=$authToken';
    final url = Uri.parse(uri);

    try {
      isFavorite = !isFavorite;
      await http.put(url, body: jsonEncode( prod.isFavorite));

      notifyListeners();

      print(isFavorite);
    } catch (error) {
      print(error);
      print('error aya');

      isFavorite = !isFavorite;
      notifyListeners(); 

      print(isFavorite);
      throw error;
    }
  }
}

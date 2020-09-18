import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  Future<void> fetchProducts() async {
    const url = 'https://world-cart-f1544.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final List<Product> tempData = [];
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        tempData.add(Product(
            id: prodId,
            imageUrl: prodData['imageUrl'],
            title: prodData['title'],
            isFavorite: prodData['isFavorite'],
            description: prodData['description'],
            price: prodData['price']));
      });
      _items = tempData;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  List<Product> get items {
    // if (_showFavoriteOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get itemsFavOnly {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((element) => element.id == productId);
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://world-cart-f1544.firebaseio.com/products.json';

    try {
      final response = await http.post(url,
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': false
          }));
      print(jsonDecode(response.body));
      final newProduct = Product(
          title: product.title,
          id: jsonDecode(response.body)['name'],
          imageUrl: product.imageUrl,
          description: product.description,
          price: product.price);
      _items.add(newProduct);
      print('executed');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    final url =
        'https://world-cart-f1544.firebaseio.com/products/${product.id}.json';

    try {
      await http.patch(url,
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      var indexofProduct =
          _items.indexWhere((element) => element.id == product.id);
      _items[indexofProduct] = product;
      print('product updated');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://world-cart-f1544.firebaseio.com/products/$id.json';
    try {
      await http.delete(url);
      var indexofProduct = _items.indexWhere((element) => element.id == id);
      _items.removeAt(indexofProduct);
      print('product deleted');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}

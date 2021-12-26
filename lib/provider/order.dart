import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../provider/cart.dart';

class OrderItem {
  final String orderId;
  final double totalAmount;
  final List<CartItem> orderNames;
  final DateTime orderTime;
  OrderItem({this.orderId, this.orderNames, this.orderTime, this.totalAmount});
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];
  final String authToken;
  final String userId;
  Order(this.authToken, this.userId, this._items);

  List<OrderItem> get items {
    return [..._items];
  }

  Future<void> fetchAndSetOrders() async {
    final uri =
        'https://world-cart-f1544.firebaseio.com/orders/$userId.json?auth=$authToken';
    final url = Uri.parse(uri);
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    if (extractedData == null) {
      print('poor');

      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          orderId: orderId,
          totalAmount: orderData['totalAmount'],
          orderTime: DateTime.parse(orderData['orderTime']),
          orderNames: (orderData['orderNames'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: DateTime.now().toIso8601String(),
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                  imageUrl: item['imageUrl'],
                ),
              )
              .toList(),
        ),
      );
    });
    _items = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder({
    double totalAmount,
    List<CartItem> orderNames,
  }) async {
    final uri =
        'https://world-cart-f1544.firebaseio.com/orders/$userId.json?auth=$authToken';
    final date = DateTime.now();
    final url = Uri.parse(uri);

    try {
      final response = await http.post(url,
          body: jsonEncode({
            'totalAmount': totalAmount,
            'orderNames': orderNames
                .map((e) => {
                      'price': e.price,
                      'quantity': e.quantity,
                      'title': e.title,
                      'imageUrl': e.imageUrl
                    })
                .toList(),
            'orderTime': date.toIso8601String()
          }));
      // print(jsonDecode(response.body));
      final newOrder = OrderItem(
          orderId: jsonDecode(response.body)['name'],
          orderNames: orderNames,
          orderTime: date,
          totalAmount: totalAmount);
      _items.add(newOrder);
      print('executed');
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}

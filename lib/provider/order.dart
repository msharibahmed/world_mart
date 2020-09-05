import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:world_mart/provider/cart.dart';

class OrderItem {
  final String orderId;
  final double totalAmount;
  final List<CartItem> orderNames;
  final DateTime orderTime;
  OrderItem({this.orderId, this.orderNames, this.orderTime, this.totalAmount});
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  void addOrder({
    double totalAmount,
    List<CartItem> orderNames,
  }) {
    _items.add(OrderItem(
        orderId: DateFormat('HHmmss ').format(DateTime.now()),
        totalAmount: totalAmount,
        orderNames: orderNames,
        orderTime: DateTime.now()));
    notifyListeners();
  }
}

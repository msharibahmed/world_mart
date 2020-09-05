import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/provider/order.dart';
import '../widgets/order_item_widget.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = 'order-screen';
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Card(
            elevation: 10, color: Colors.deepOrange, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('My Orders',style:TextStyle(fontSize: 20)),
            ),
      )),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItemWidget(index),
        itemCount: order.items.length,
      ),
    );
  }
}

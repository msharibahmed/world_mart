import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_body.dart';
import '../provider/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: [
          Card(
              elevation: 20,
              color: Colors.deepOrange,
              child: Consumer<Cart>(
                builder: (context, cart, _) => FlatButton(
                    onPressed: cart.clearCart,
                    child: Text('Clear Cart',
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              ))
        ],
      ),
      body: CartBody(),
    );
  }
}

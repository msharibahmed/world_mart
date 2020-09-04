import 'package:flutter/material.dart';

import '../widgets/cart_body.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: CartBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../widgets/cart_item.dart' as ci;

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, endex) => ci.CartItem(endex),
            itemCount: cartData.itemCount,
          )),
          Card(
            
            margin: EdgeInsets.all(10),
            elevation: 10,
            shadowColor: Colors.deepOrange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'TOTAL:',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Chip(
                      elevation: 10,
                      shadowColor: Colors.deepOrange,
                      label: Text(
                        '\$${cartData.totalAmount.toStringAsFixed(2)}',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

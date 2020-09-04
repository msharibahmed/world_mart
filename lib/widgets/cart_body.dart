import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../widgets/cart_item.dart' as ci;

class CartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return cartData.items.isEmpty?Center(child:Text('Cart is Empty!',style: TextStyle(fontSize: 25),)): Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, endex) {
              return Dismissible(
                // Show a red background as the item is swiped away.
                background: Container(color: Colors.red),
                key: Key(cartData.items.keys.toList()[endex]),
                onDismissed: (direction) {
                  cartData.deleteCartItem(cartData.items.keys.toList()[endex]);
                 

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.deepOrange[100],
                      elevation: 10,
                      content: Text('Removed From Cart!',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))));
                },
                child: ci.CartItem(endex),
              );
            },
            itemCount: cartData.itemCount,
          )),
          Card(
            margin: EdgeInsets.all(10),
            elevation: 10,
            shadowColor: Colors.deepOrange,
            child: FittedBox(
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
                      backgroundColor: Colors.greenAccent[200],
                        elevation: 10,
                        shadowColor: Colors.deepOrange,
                        label: Text(
                          '\$${cartData.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                  FlatButton(onPressed: (){}, child: Text('Order Now',style:TextStyle(fontSize: 20,color:Colors.deepOrangeAccent,fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../screens/order_screen.dart';

import '../provider/cart.dart';
import '../widgets/cart_item.dart' as ci;
import '../provider/order.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  bool v = true;
  ScrollController ctrl;
  @override
  void dispose() {
    super.dispose();
    ctrl.removeListener(() {
      setState(() {
        v = ctrl.position.userScrollDirection == ScrollDirection.forward;
        print(v);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ctrl = ScrollController();
    ctrl.addListener(() {
      setState(() {
        v = ctrl.position.userScrollDirection == ScrollDirection.forward;
        print(v);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final orderData = Provider.of<Order>(context);

    return cartData.items.isEmpty
        ? Center(
            child: Text(
            'Cart is Empty!',
            style: TextStyle(fontSize: 25),
          ))
        : Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                  controller: ctrl,
                  itemBuilder: (context, endex) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) {
                        return showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: Text('Are you sure?'),
                                  content: Text('Item will be deleted!'),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop(true);
                                      },
                                      child: Text('Yes'),
                                    ),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop(false);
                                        },
                                        child: Text('No'))
                                  ],
                                ));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(
                        padding: EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      key: Key(cartData.items.keys.toList()[endex]),
                      onDismissed: (direction) {
                        cartData.deleteCartItem(
                            cartData.items.keys.toList()[endex]);

                        Scaffold.of(context).showSnackBar(
                            cartData.snackBar('Removed From Favorites!'));
                      },
                      child: ci.CartItem(endex),
                    );
                  },
                  itemCount: cartData.itemCount,
                )),
                Visibility(
                  visible: v,
                  child: Card(
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
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          FlatButton(
                              onPressed: () {
                                orderData.addOrder(
                                    totalAmount: cartData.totalAmount,
                                    orderNames: cartData.items.values.toList());
                                Navigator.pushReplacementNamed(
                                    context, OrderScreen.routeName);
                                cartData.clearCart();
                              },
                              child: Text('Order Now',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

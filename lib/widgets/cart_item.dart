import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/provider/cart.dart';

class CartItem extends StatelessWidget {
  final int index;
  CartItem(this.index);
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context).items.values.toList()[index];

    return Card(
      elevation: 10,
      shadowColor: Colors.purple,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      cartData.imageUrl,
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartData.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('\$ ' + cartData.price.toString() + '/Piece'),
                    ],
                  ),
                ),
                Spacer(),
                Text(cartData.quantity.toString() + 'x',
                    style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 65),
                child: Text(
                    'Total: \$ ' +
                        (cartData.quantity * cartData.price).toStringAsFixed(2),
                    style: TextStyle(fontSize: 20)),
              ),
              Spacer(),
             Consumer<Cart>(builder: (context,cart,_)=> IconButton(
                  icon: Icon(
                    Icons.indeterminate_check_box,
                    color: Colors.deepOrangeAccent[100],
                    size: 35,
                  ),
                  onPressed: () {
                    cart.decrement(cart.items.keys.toList()[index],index);
                  }),),
              Text(cartData.quantity.toString(),
                  style: TextStyle(fontSize: 20)),
              Consumer<Cart>(builder: (context,cart,_)=> IconButton(
                  icon: Icon(
                    Icons.add_box,
                    color: Colors.deepOrange,
                    size: 35,
                  ),
                  onPressed: () {
                    cart.increment(cart.items.keys.toList()[index]);
                  }),),
            ],
          )
        ],
      ),
    );
  }
}

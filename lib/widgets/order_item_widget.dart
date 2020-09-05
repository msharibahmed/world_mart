import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/provider/order.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  OrderItemWidget(this.index);
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    return Card(
      elevation: 10,
      shadowColor: Colors.deepOrange,
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: Text('ORDER #' + order.items[index].orderId,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Text(
                  DateFormat('dd MMM').format(order.items[index].orderTime),
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('Total Amount: ',
                      style: TextStyle(fontSize: 17, color: Colors.grey)),
                ),
                Chip(
                    elevation: 10,
                    backgroundColor: Colors.green,
                    label: Text(
                      '\$${order.items[index].totalAmount}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            ExpansionTile(
              title: Text('Product Details',style: TextStyle(color: Colors.black),),
              children: [
                ...(order.items[index].orderNames).toList().map((e) => Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Container(
                        width: double.infinity,
                        child: Card(
                            elevation: 10,
                            shadowColor: Colors.deepOrange,
                            child: Row(
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: Image.network(
                                      e.imageUrl,
                                      fit: BoxFit.fill,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(e.title,style:TextStyle(fontSize: 25,fontWeight: FontWeight.w300)),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.quantity.toString() + 'x',style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                )
                              ],
                            )),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

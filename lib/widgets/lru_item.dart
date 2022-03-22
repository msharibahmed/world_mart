import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class LruItem extends StatelessWidget {
  final String title;
  final String id;

  LruItem(this.title, this.id);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: id);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(34)),
            color: Colors.blue[100],
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

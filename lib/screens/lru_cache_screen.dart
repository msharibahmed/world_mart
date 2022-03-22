import 'package:flutter/material.dart';
import 'package:world_mart/provider/products.dart';

import 'package:provider/provider.dart';

import '../widgets/lru_item.dart';

class LRUCacheScreen extends StatelessWidget {
  static const routeName = '/lru_screen';

  LRUCacheScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Provider.of<Products>(context)
            .getOurRecent()
            .map((proData) => LruItem(
                products.getByid(proData).title, products.getByid(proData).id))
            .toList(),
      ),

      /* SingleChildScrollView(
        child: Column(
          children: products
              .getOurRecent()
              .map((proData) => LruItem(products.getByid(proData).title,
                  products.getByid(proData).id))
              .toList(),
        ),
       */
    );
  }
}

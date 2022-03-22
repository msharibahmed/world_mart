import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/screens/lru_cache_screen.dart';

import 'product_item.dart';
import '../provider/products.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFav;
  ProductsGrid(this.showFav);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  var _boolCheck = true;
  var loadng = true;
  @override
  void initState() {
    super.initState();
    // Provider.of<Products>(context).fetchProducts(); //WONT WORK!

    // //but we can use ths hack
    // Future.delayed(Duration.zero)
    //     .then((_) => Provider.of<Products>(context).fetchProducts());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // //we can also use ths
    if (_boolCheck == true) {
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          loadng = false;
        });
      });
    }
    _boolCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        widget.showFav ? productsData.itemsFavOnly : productsData.items;
    return loadng
        ? Align(child: CircularProgressIndicator())
        : Column(
            children: [
              Flexible(child: LRUCacheScreen()),
              Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 3 / 2),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      return ChangeNotifierProvider.value(
                        value: products[i],
                        child: ProductItem(productsData.items[i]),
                      );
                    }),
              )
            ],
          );
  }
}

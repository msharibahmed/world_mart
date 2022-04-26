import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/provider/products.dart';
import 'package:world_mart/widgets/search_list_item.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, ShowAll }

class ProductOverviewScreen extends StatelessWidget {
  static const routeName = 'product-overview';
  final AppBar appBar;
  final bool favoriteOnly;
  ProductOverviewScreen({this.appBar, this.favoriteOnly});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) =>
                    Consumer<Products>(builder: (context, data, _) {
                      var _items = data.searchItems;
                      return AlertDialog(
                        title: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search by name",
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: ((value) =>
                              data.showProductsBySearch(value.trim())),
                        ),
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: data.searchItems.isEmpty
                              ? Center(
                                  child: Text("Nothing to show!"),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _items.length,
                                  itemBuilder: (context, idx) => SearchListIten(
                                      _items[idx].id,
                                      _items[idx].title,
                                      _items[idx].imageUrl)),
                        ),
                      );
                    }));
          },
        ),
        appBar: appBar,
        body: ProductsGrid(favoriteOnly));
  }
}

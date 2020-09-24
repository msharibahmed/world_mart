import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/screens/edit_product_screen.dart';

import '../provider/products.dart';
import '../widgets/manage_product_card.dart';

class ManageProductScreen extends StatefulWidget {
  static const routeName = 'manage-product-screen';

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  bool v = true;
  ScrollController ctrl;
  var _boolCheck1 = true;
  var _boolCheck2 = true;
  @override
  void didChangeDependencies() {
    if (_boolCheck1) {
      Provider.of<Products>(context, listen: false)
          .fetchProducts(true)
          .then((value) {
        setState(() {
          _boolCheck2 = false;
        });
      });
    }
    _boolCheck1 = false;
    super.didChangeDependencies();
  }

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

  Future<void> _refreshIndicator(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    print('rebuldng....');
    return Scaffold(
      floatingActionButton: Visibility(
        visible: v,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditProductScreen.routeName,
            );
          },
          label: Text('Add Product'),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.tealAccent[400],
          elevation: 5,
          isExtended: true,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('Manage Your Products'),
      ),
      body: _boolCheck2
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refreshIndicator(context),
              child: Consumer<Products>(
                builder: (context, data, __) => ListView.builder(
                  controller: ctrl,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ManageProductCard(data.items[i].id, data.items[i].title,
                            data.items[i].imageUrl),
                      ],
                    );
                  },
                  itemCount: data.items.length,
                ),
              )),
    );
  }
}

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../screens/edit_product_screen.dart';

class ManageProductCard extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String title;
  final bool isSearch;

  ManageProductCard(this.id, this.title, this.imageUrl,
      [this.isSearch = false]);

  @override
  _ManageProductCardState createState() => _ManageProductCardState();
}

class _ManageProductCardState extends State<ManageProductCard> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 5,
      shadowColor: Colors.pink,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
        title: Text(widget.title),
        trailing: widget.isSearch
            ? Container()
            : Container(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EditProductScreen.routeName,
                              arguments: widget.id);
                        }),
                    Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(60)),
                            depth: 8,
                            lightSource: LightSource.topLeft,
                            color: Colors.white),
                        child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              products
                                  .deleteProduct(widget.id)
                                  .catchError((error) async {
                                return await showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: Text('Error Message'),
                                          content: Text('Something went wrong'),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Okay!')),
                                          ],
                                        ));
                              });
                            }))
                  ],
                ),
              ),
      ),
    );
  }
}

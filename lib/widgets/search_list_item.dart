import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../screens/product_detail_screen.dart';

class SearchListIten extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String title;

  SearchListIten(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  _SearchListItenState createState() => _SearchListItenState();
}

class _SearchListItenState extends State<SearchListIten> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: widget.id);

        Provider.of<Products>(context, listen: false).addRecent(widget.id);
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 5,
        shadowColor: Colors.pink,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.imageUrl),
          ),
          title: Text(widget.title),
        ),
      ),
    );
  }
}

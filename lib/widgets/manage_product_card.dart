import 'package:flutter/material.dart';
import 'package:world_mart/screens/edit_product_screen.dart';

class ManageProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  ManageProductCard(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      shadowColor: Colors.pink,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl ),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.edit, color: Colors.green),
                  onPressed: () {
                    Navigator.pushNamed(context, EditProductScreen.routeName);
                  }),
              IconButton(
                  icon: Icon(Icons.delete, color: Colors.red), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

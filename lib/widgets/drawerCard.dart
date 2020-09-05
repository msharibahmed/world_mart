import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {
  final String name;
  final IconData iconName;
  DrawerCard(this.name, this.iconName);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.deepOrange,
      color: Colors.deepOrange[300],
      child: ListTile(
        leading: Icon(
          iconName,
          color: Colors.black,
        ),
        title: Text(name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
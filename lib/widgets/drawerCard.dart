import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class DrawerCard extends StatelessWidget {
  final String name;
  final IconData iconName;
  final String onTapFunction;
  DrawerCard(this.name, this.iconName, this.onTapFunction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.deepOrange,
      color: Colors.deepOrange[300],
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, onTapFunction);
          CustomDrawer.of(context).close();
        },
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

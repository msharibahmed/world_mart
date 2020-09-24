import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_mart/provider/auth.dart';
import 'custom_drawer.dart';

class DrawerCard extends StatelessWidget {
  final String name;
  final IconData iconName;
  final String onTapFunction;
  DrawerCard(this.name, this.iconName, this.onTapFunction);

  @override
  Widget build(BuildContext context) {
    final auth=Provider.of<Auth>(context,listen: false);
    return Card(
      elevation: 10,
      shadowColor: Colors.deepOrange,
      color: Colors.deepOrange[300],
      child: ListTile(
        onTap: () {
          CustomDrawer.of(context).close();
         name=='Log Out' ?auth.logout():Navigator.pushNamed(context, onTapFunction);
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

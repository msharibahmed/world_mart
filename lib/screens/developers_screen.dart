import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
    static const routeName = '/devs';

  const DeveloperScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Sharib, Shresth, Harshit"),),);
  }
}

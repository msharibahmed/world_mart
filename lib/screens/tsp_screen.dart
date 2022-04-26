import 'package:flutter/material.dart';
import 'package:world_mart/provider/tsp.dart';

class TspScreen extends StatefulWidget {
  static const routeName = "/tsp-screen";
  TspScreen({Key key}) : super(key: key);

  @override
  State<TspScreen> createState() => _TspScreenState();
}

class _TspScreenState extends State<TspScreen> {
  int minCost = -1;
  List<String> paths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("TSP Implementation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/tsp_nodes.jpeg"),
            ElevatedButton.icon(
              icon: Icon(
                Icons.route,
                color: Colors.black,
              ),
              onPressed: () {
                Map<int, List<String>> _x = getMinimumCost();
                print(minCost);
                setState(() {
                  minCost = _x.keys.first;
                  paths = _x[minCost];
                });
              },
              label: Text(
                "Give optimal routes cost",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if(paths.isNotEmpty)
            Text(
              "Minimum cost when origin is City 1 -> " +
                  (minCost == -1 ? "" : minCost.toString()),
            ),
            SizedBox(
              height: 20,
            ),
            if(paths.isNotEmpty)
            Text(
              "Possible paths with MINIMUM COST: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ...paths.map((e) => Text(e,
                        style: TextStyle(fontWeight: FontWeight.w900,fontSize: 35),
      
            )).toList()
          ],
        ),
      ),
    );
  }
}

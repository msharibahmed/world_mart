import 'dart:collection';

import 'dart:math';

String frozenSet(remSet) {
  var arr = [];
  for (var e in remSet) {
    arr.add(e);
  }

  arr.sort();
  String hashcode = "";
  for (var e in arr) {
    hashcode += (e.toString() + "-");
  }

  return hashcode;
}

var graph = {
  1: [2, 3, 4],
  2: [1, 4, 3],
  3: [1, 2, 4],
  4: [1, 2, 3]
};

var cost = {
  "1-2": 3,
  "2-1": 3,
  "2-3": 2,
  "3-2": 2,
  "3-4": 2,
  "4-3": 2,
  "1-4": 1,
  "4-1": 1,
  "1-3": 3,
  "3-1": 3,
  "4-2": 4,
  "2-4": 4
};
Map<int,List<String>> routes = {};

String getEdge(a, b) {
  return a.toString() + "-" + b.toString();
}

int origin = 1;
var mem = {};

int tsp(start, remaining, initString, costs) {
//base condition
  if (remaining.length == 0) {
    if (routes.containsKey(costs + cost[getEdge(start, origin)])) {
      routes[costs + cost[getEdge(start, origin)]]
          .add(initString + "->" + origin.toString());
    } else {
      routes[costs + cost[getEdge(start, origin)]] = [
        initString + "->" + origin.toString()
      ];
    }
    return cost[getEdge(start, origin)];
  }

//memoization
  if (mem.containsKey(start.toString() + "@" + frozenSet(remaining))) {
    return mem[start.toString() + "@" + frozenSet(remaining)];
  }
//code

  int miny = 2147483648;

  for (var nbr in remaining) {
    //remaining.remove(nbr);
    var nrem = HashSet<int>();
    for (var els in remaining) {
      if (els != nbr) {
        nrem.add(els);
      }
    }

    miny = min(
        cost[getEdge(start, nbr)] +
            tsp(nbr, nrem, initString + "->" + nbr.toString(),
                costs + cost[getEdge(start, nbr)]),
        miny);

    // remaining.add(nbr);
  }

  mem[start.toString() + "@" + frozenSet(remaining)] = miny;
  return miny;
}

Map<int, List<String>> getMinimumCost() {
  var rem = HashSet<int>();
  graph.forEach((k, v) => rem.add(k));
  rem.remove(origin);
  int ans = (tsp(origin, rem, origin.toString(), 0));
  print(routes);
  int key = ans;
  List<String> value = routes[key];

  return {key:value};
}

import 'package:flutter/material.dart';

import 'product.dart';

class Dll {
  String id;
  Dll next;
  Dll prev;

  Dll({@required this.id, this.next, this.prev});
}

class Lru {
  int capacity;
  Dll head;
  Dll tail;
  int length;
  Map hash;

  Lru(
    int capacity,
  ) {
    print("Lru inititalized");
    this.capacity = capacity;
    head = Dll(id: "-1");
    tail = head;
    length = 0;
    hash = {};
  }

  void use(String id) {
    if (hash.containsKey(id)) {
      Dll node = hash[id];
      if (node.next != null) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
        tail.next = node;
        node.prev = tail;
        node.next = null;
        tail = node;
      }
    } else {
      print("making Node");
      Dll node = Dll(id: id);
      hash[id] = node;
      tail.next = node;
      node.prev = tail;
      node.next = null;
      tail = node;
      length += 1;
      if (length > capacity) {
        Dll removed = head.next;
        head.next = head.next.next;
        head.next.prev = head;
        hash.remove(removed.id);

        length -= 1;
      }
    }
  }

  List<String> getAll() {
    List<String> all = [];
    Dll start = tail;
    while (start.id != "-1") {
      all.add(start.id);
      start = start.prev;
    }

    return all;
  }
}

class MajorProducts with ChangeNotifier {}

import 'package:flutter/material.dart';

class CounterState extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter += 1;
    notifyListeners();
  }

  void decrement() {
    counter -= 1;
    notifyListeners();
  }
}

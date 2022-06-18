import 'package:flutter/material.dart';

class ScreenProvider with ChangeNotifier {
  int screenIndex = 0;
  void setScreenIndex(int index) {
    screenIndex = index;
    notifyListeners();
  }
}

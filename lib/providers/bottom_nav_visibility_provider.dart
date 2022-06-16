import 'package:flutter/material.dart';

class BottomBarVisibilityProvider extends ChangeNotifier {
  bool isVisible = true;

  void show() {
    if (!isVisible) {
      isVisible = true;
      notifyListeners();
    }
  }

  void hide() {
    if (isVisible) {
      isVisible = false;
      notifyListeners();
    }
  }
}

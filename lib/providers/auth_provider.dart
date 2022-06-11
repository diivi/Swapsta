import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String id;
  String fullName;
  String email;
  String imageUrl;
  Map<String, bool> wishlist;

  Auth({
    required this.id,
    required this.fullName,
    required this.email,
    required this.imageUrl,
    required this.wishlist,
  });

  void toggleWishlist(String id) {
    var key = wishlist.containsKey(id);
    if (key) {
      wishlist.remove(id);
    } else {
      wishlist[id] = true;
    }
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Swappable {
  final String id;
  final String name;
  final List<String> imageUrls;
  final String description;
  final String category;
  final String ownerName;
  final String ownerId;
  final String ownerImageUrl;
  final double condition;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? categoryEmoji;
  final DateTime? swappedAt;
  final int? swapRequests;

  Swappable({
    required this.id,
    required this.name,
    required this.imageUrls,
    required this.description,
    required this.category,
    required this.ownerName,
    required this.ownerId,
    required this.ownerImageUrl,
    required this.condition,
    required this.createdAt,
    required this.updatedAt,
    this.categoryEmoji,
    this.swapRequests,
    this.swappedAt,
  });
}

class SwappableProvider extends ChangeNotifier {
  List<Swappable> _swappables = [];

  bool isFetching = false;

  List<Swappable> get swappables => _swappables;
  SwappableProvider() {
    fetchSwappables(); // Call the function to fetch data from Firebase
  }
  Future<void> fetchSwappables() async {
    isFetching = true;
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('items').get();
      final swappables = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Swappable(
          id: doc.id,
          name: data['name'],
          imageUrls: List<String>.from(data['imageUrls']),
          description: data['description'],
          category: data['category'],
          ownerName: data['ownerName'],
          ownerId: data['ownerId'],
          ownerImageUrl: data['ownerImageUrl'],
          condition: data['condition'].toDouble(),
          createdAt: data['createdAt'].toDate(),
          updatedAt: data['updatedAt'].toDate(),
          swapRequests: data['swapRequests'],
        );
      }).toList();

      _swappables = swappables;
      print(_swappables);
      isFetching = false;
      notifyListeners();
    } catch (error) {
      print('Error fetching swappables: $error');
    }
  }
}

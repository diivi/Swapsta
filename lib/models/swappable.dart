import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swapsta/models/swap.dart';

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
  List<Swap> _sentSwaps = [];
  List<Swap> _recievedSwaps = [];
  List<Swap> get recievedSwaps => _recievedSwaps;
  List<Swap> get sentSwaps => _sentSwaps;
  List<Swappable> get swappables => _swappables;
  SwappableProvider() {
    fetchSwappables();
    fetchSwaps(); // Call the function to fetch data from Firebase
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

  Future<void> fetchSwaps() async {
    try {
      final authUser = FirebaseAuth.instance.currentUser!;
      final querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      final swappables = querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data['email'] == authUser.email) {
          return data['sentSwaps'];
        }
      }).toList();
      if (swappables[0] == null) {
        swappables.removeAt(0);
      }
      print(swappables);
      final recievedSwaps = querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data['email'] == authUser.email) {
          return data['requestedSwaps'];
        }
      }).toList();
      if (recievedSwaps[0] == null) {
        recievedSwaps.removeAt(0);
      }
      print(recievedSwaps);
      List<Swap> swaps = [];
      if (swappables[0] != null) {
        for (var entry in swappables[0]) {
          if (entry != null && entry is Map<dynamic, dynamic>) {
            swaps.add(Swap(
              id: entry['id'],
              requesterId: entry['requesterId'],
              requesterName: entry['requesterName'],
              requesterImage: entry['requesterImage'],
              requesterPhone: entry['requesterPhone'],
              ownerId: entry['ownerId'],
              ownerName: entry['ownerName'],
              ownerImage: entry['ownerImage'],
              requesterItemId: entry['requestItemId'],
              requesterItemName: entry['requesterItemName'],
              requesterItemImages:
                  List<String>.from(entry['requesterItemImages']),
              requesterItemDescription: entry['requesterItemDescription'],
              requesterItemCategory: entry['requesterItemCategory'],
              requesterItemCreatedAt:
                  DateTime.parse(entry['requesterItemCreatedAt']),
              requesterItemUpdatedAt:
                  DateTime.parse(entry['requesterItemUpdatedAt']),
              requesterItemCondition:
                  entry['requesterItemCondition'].toDouble(),
              // requesterItemCategoryEmoji: entry['requesterItemCategoryEmoji'],
              ownerItemId: entry['ownerItemId'],
              ownerItemName: entry['ownerItemName'],
              ownerItemImages: List<String>.from(entry['ownerItemImages']),
              ownerItemDescription: entry['ownerItemDescription'],
              ownerItemCategory: entry['ownerItemCategory'],
              ownerItemCreatedAt: DateTime.parse(entry['ownerItemCreatedAt']),
              ownerItemUpdatedAt: DateTime.parse(entry['ownerItemUpdatedAt']),
              ownerItemCondition: entry['ownerItemCondition'].toDouble(),
              // ownerItemCategoryEmoji: entry['ownerItemCategoryEmoji'],
              isAccepted: entry['status'] == 'requested' ? false : true,
            ));
          }
        }
      }
      List<Swap> rSwaps = [];
      if (recievedSwaps[0] != null) {
        for (var entry in recievedSwaps[0]) {
          if (entry != null && entry is Map<dynamic, dynamic>) {
            rSwaps.add(Swap(
              id: entry['id'],
              requesterId: entry['requesterId'],
              requesterName: entry['requesterName'],
              requesterImage: entry['requesterImage'],
              requesterPhone: entry['requesterPhone'],
              ownerId: entry['ownerId'],
              ownerName: entry['ownerName'],
              ownerImage: entry['ownerImage'],
              requesterItemId: entry['requestItemId'],
              requesterItemName: entry['requesterItemName'],
              requesterItemImages:
                  List<String>.from(entry['requesterItemImages']),
              requesterItemDescription: entry['requesterItemDescription'],
              requesterItemCategory: entry['requesterItemCategory'],
              requesterItemCreatedAt:
                  DateTime.parse(entry['requesterItemCreatedAt']),
              requesterItemUpdatedAt:
                  DateTime.parse(entry['requesterItemUpdatedAt']),
              requesterItemCondition:
                  entry['requesterItemCondition'].toDouble(),
              // requesterItemCategoryEmoji: entry['requesterItemCategoryEmoji'],
              ownerItemId: entry['ownerItemId'],
              ownerItemName: entry['ownerItemName'],
              ownerItemImages: List<String>.from(entry['ownerItemImages']),
              ownerItemDescription: entry['ownerItemDescription'],
              ownerItemCategory: entry['ownerItemCategory'],
              ownerItemCreatedAt: DateTime.parse(entry['ownerItemCreatedAt']),
              ownerItemUpdatedAt: DateTime.parse(entry['ownerItemUpdatedAt']),
              ownerItemCondition: entry['ownerItemCondition'].toDouble(),
              // ownerItemCategoryEmoji: entry['ownerItemCategoryEmoji'],
              isAccepted: entry['status'] == 'requested' ? false : true,
            ));
          }
        }
      }
      _recievedSwaps = rSwaps;
      _sentSwaps = swaps;
      print(_recievedSwaps);
      print(_sentSwaps);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}

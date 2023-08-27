import 'package:flutter/material.dart';

import '../models/swappable.dart';

class Swappables with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Swappable> _swappables = [
    Swappable(
      id: '1',
      name: 'Rain-Jacket',
      description:
          'High Quality Nylon Polyester Blend Fabric with Water Resistance, Hood is rolled into the Collar of the Jacket.',
      imageUrls: [
        'https://4.imimg.com/data4/KC/AS/MY-23240069/rain-jackets-500x500.jpg',
      ],
      category: 'Clothing',
      condition: 5,
      createdAt: DateTime(2020, 1, 1),
      updatedAt: DateTime(2020, 1, 1),
      ownerName: 'Divyansh Singh',
      ownerId: '1',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/41837037?v=4',
      categoryEmoji: '👕',
      swapped: false
    ),
    Swappable(
      id: '2',
      name: 'Bag',
      description:
          'A perfect pick for daily use. Expandable & Lightweight With 30 L Capcity',
      imageUrls: [
        'https://m.media-amazon.com/images/I/51BPWfLZHFL._UX569_.jpg',
        'https://m.media-amazon.com/images/I/51oGyFoRYPL.jpg'
      ],
      category: 'Other',
      condition: 4,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerName: 'Shivansh Singh',
      categoryEmoji: '📚',
      ownerId: '2',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/89853707?v=4',
      swapped: false
    ),
    Swappable(
      id: '3',
      name: 'Realme buds Q',
      description:
          'realme Buds Q, weighs only 3.6g and is made of light but strong PC+ABS special polymer composite. The ergonomic coracoid structure can perfectly fit',
      imageUrls: [
        'https://m.media-amazon.com/images/I/71LOa1JA0qL._AC_SX425_.jpg',
      ],
      category: 'Electronics',
      condition: 3,
      createdAt: DateTime(2021, 1, 1),
      updatedAt: DateTime(2021, 1, 1),
      ownerName: 'Aryan Sethia',
      categoryEmoji: '📱',
      ownerId: '3',
      swapped: false,
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/76778991?v=4',
    ),
    Swappable(
      id: '4',
      name: 'Adidas Brazuca',
      description: 'very good football it goes woosh not swoosh',
      imageUrls: [
        'https://m.media-amazon.com/images/I/81DLl205vYL._SL1500_.jpg',
        'https://m.media-amazon.com/images/I/81FXrcKuX+L._SL1500_.jpg'
      ],
      category: 'Sports',
      condition: 2.5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerName: 'Yathansh Raj Sharma',
      categoryEmoji: '⚽',
      ownerId: '4',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/88828094?v=4',
      swapped: false
    ),
    Swappable(
      id: '5',
      name: 'Hat',
      description:
          'Made by natural-tone handwoven toquilla straw, which is top quality skin-friendly material.',
      imageUrls: [
        'https://m.media-amazon.com/images/I/71tKXRvS9IL._UL1500_.jpg',
      ],
      category: 'Clothing',
      condition: 1.5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerName: 'Devina Bhatnagar',
      categoryEmoji: '👕',
      ownerId: '5',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/89126339?v=4',
      swapped: false
    ),
    Swappable(
      id: '6',
      name: 'Cosco Skates',
      description: 'Ideal for kids | material metal base with rubber wheels',
      imageUrls: [
        'https://m.media-amazon.com/images/I/91OVpIb9g6L._SX522_.jpg',
      ],
      category: 'Clothing',
      condition: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerName: 'Gautam Nanda',
      categoryEmoji: '⚽',
      ownerId: '6',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/76778991?v=4',
      swapped: false
    ),
  ];

  List<Swappable> get swappables {
    return [..._swappables];
  }
}

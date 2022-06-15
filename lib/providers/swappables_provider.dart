import 'package:flutter/material.dart';

import '../models/swappable.dart';

class Swappables with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Swappable> _swappables = [
    Swappable(
      id: '1',
      name: 'Rifle Paper Co. Pocket Book 32 Pages, Unlined',
      description:
          'Very nice floral notebook has 32 pages unlined good for journaling, sketching, making notes etc. would prefer to swap with another stationery product.',
      imageUrls: [
        'https://images.unsplash.com/photo-1528938102132-4a9276b8e320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
      ],
      category: 'Stationery',
      condition: 5,
      createdAt: DateTime(2020, 1, 1),
      updatedAt: DateTime(2020, 1, 1),
      ownerName: 'Divyansh Singh',
      ownerId: '1',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/41837037?v=4',
      categoryEmoji: '📚',
    ),
    Swappable(
      id: '2',
      name: 'cet',
      description:
          'very cute lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quidem. Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, quidem.',
      imageUrls: [
        'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
      ],
      category: 'Other',
      condition: 4,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerName: 'Shivansh Singh',
      categoryEmoji: '📚',
      ownerId: '2',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/89853707?v=4',
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
    ),
    Swappable(
      id: '5',
      name: 'Cute Hat',
      description: 'cute hat',
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
    ),
    Swappable(
      id: '6',
      name: 'My Heart',
      description:
          'Long lasting, delicate and tender. My heart is ideal for serious relationships. I am fat, will have high BP, will die at 50. You get to keep all my village properties and dahej wala fridge. Lets swap hearts',
      imageUrls: [
        'https://www.cardio.com/hs-fs/hubfs/human%20heart%20illustration.jpeg?width=900&name=human%20heart%20illustration.jpeg',
      ],
      category: 'Clothing',
      condition: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ownerName: 'Gautam Nanda',
      categoryEmoji: '👕',
      ownerId: '6',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/76778991?v=4',
    ),
  ];

  List<Swappable> get swappables {
    return [..._swappables];
  }
}

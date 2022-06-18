library swapsta.globals;

import 'package:swapsta/models/category.dart';

import 'models/swap.dart';
import 'models/swappable.dart';

final List<Swap> sentSwaps = [
  Swap(
    id: "1",
    requesterId: "99",
    requesterName: "Divyansh Singh",
    requesterImage: "https://i.pravatar.cc/300",
    requesterPhone: "123456789",
    ownerId: "100",
    ownerName: "Kartik Dang",
    ownerImage: "https://i.pravatar.cc/300",
    ownerPhone: "123456789",
    requesterItemId: "1",
    requesterItemName: "Rifle Paper Co. Pocket Book 32 Pages, Unlined",
    requesterItemCover:
        "https://images.unsplash.com/photo-1528938102132-4a9276b8e320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
    requesterItemCondition: 2.5,
    ownerItemId: "5",
    ownerItemName: "cet",
    ownerItemCover:
        "https://images.unsplash.com/photo-1528938102132-4a9276b8e320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
    ownerItemCondition: 4,
  ),
];

final List<Swappable> wishlistedSwappables = [
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
    id: '23',
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
    id: '24',
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
];

final List<Swappable> mySwappables = [
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
];

final List<Category> categories = [
  Category(
    id: '0',
    name: 'All Categories',
    emoji: '',
  ),
  Category(
    id: '1',
    name: 'Stationery',
    emoji: '📚',
  ),
  Category(
    id: '2',
    name: 'Clothing',
    emoji: '👕',
  ),
  Category(
    id: '3',
    name: 'Electronics',
    emoji: '📱',
  ),
  Category(
    id: '4',
    name: 'Sports',
    emoji: '⚽',
  ),
];

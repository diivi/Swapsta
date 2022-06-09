library swapsta.globals;

import 'package:swapsta/models/Swappable.dart';
import 'package:swapsta/models/category.dart';

final List<Swappable> swappables = [
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
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isWishlisted: false,
      ownerName: 'Divyansh Singh',
      ownerImageUrl: 'https://avatars.githubusercontent.com/u/41837037?v=4'),
  Swappable(
    id: '2',
    name: 'cet',
    description: 'very cute cat',
    imageUrls: [
      'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    ],
    category: 'Other',
    condition: 5,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    isWishlisted: true,
    ownerName: 'Shivansh Singh',
    ownerImageUrl:
        'https://instagram.fdel27-5.fna.fbcdn.net/v/t51.2885-19/281339469_3166469946949927_3025707922524716103_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fdel27-5.fna.fbcdn.net&_nc_cat=107&_nc_ohc=t780l7AHFBQAX_MPozY&tn=2MV9UHARVHI5KVU8&edm=AHG7ALcBAAAA&ccb=7-5&oh=00_AT8YGWqtnIbAUpfVO7WDPztDbvNTPQ5YpxZ0RrlpAmd78w&oe=62A6D660&_nc_sid=5cbaad',
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
    condition: 3.5,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    isWishlisted: false,
    ownerName: 'Aryan Sethia',
    ownerImageUrl: 'https://avatars.githubusercontent.com/u/76778991?v=4',
  ),
];

final List<Category> categories = [
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
];

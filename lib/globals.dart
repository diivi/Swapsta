library swapsta.globals;

import 'package:swapsta/models/category.dart';

import 'models/swap.dart';

final List<Swap> swaps = [];

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

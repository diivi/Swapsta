import 'package:flutter/material.dart';
import 'package:swapsta/models/swap.dart';

class SwapHistory with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Swap> _swapHistory = [
    Swap(
      id: "1",
      requesterId: "99",
      requesterName: "Divyansh Singh",
      requesterImage: "https://i.pravatar.cc/300",
      ownerId: "100",
      ownerName: "Kartik Dang",
      ownerImage: "https://i.pravatar.cc/300",
      requesterItemId: "1",
      requesterItemName: "Rifle Paper Co. Pocket Book 32 Pages, Unlined",
      requesterItemCategory: 'Stationery',
      requesterItemCreatedAt: DateTime.now(),
      requesterItemUpdatedAt: DateTime.now(),
      requesterItemDescription:
          'A book with 32 pages. It is a pocket book with a cover. It is unlined.',
      requesterItemImages: [
        "https://images.unsplash.com/photo-1528938102132-4a9276b8e320?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
      ],
      requesterItemCondition: 2.5,
      ownerItemId: "5",
      ownerItemName: "cet",
      ownerItemImages: [
        "https://images.pexels.com/photos/45201/kitty-cat-kitten-pet-45201.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
      ],
      ownerItemCategory: 'Other',
      ownerItemCondition: 4,
      ownerItemCreatedAt: DateTime.now(),
      ownerItemUpdatedAt: DateTime.now(),
      ownerItemDescription: 'A cat',
    ),
  ];

  List<Swap> get swapHistory {
    return [..._swapHistory];
  }
}

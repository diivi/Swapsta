import 'package:flutter/material.dart';
import 'package:swapsta/models/swap.dart';
import 'package:swapsta/models/swappable.dart';
import 'package:swapsta/widgets/swap_swappable_card.dart';

class SwapSwappableRow extends StatelessWidget {
  const SwapSwappableRow({Key? key, required this.swap}) : super(key: key);
  final Swap swap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            // currently creating swappables on the go, will give id and fetch it on swappable screen later.
            child: SwapSwappableCard(
              swappable: Swappable(
                id: swap.requesterItemId,
                name: swap.requesterItemName,
                imageUrls: swap.requesterItemImages,
                description: swap.requesterItemDescription,
                category: swap.requesterItemCategory,
                condition: swap.requesterItemCondition,
                createdAt: swap.requesterItemCreatedAt,
                updatedAt: swap.requesterItemUpdatedAt,
                ownerId: swap.requesterId,
                ownerName: swap.requesterName,
                ownerImageUrl: swap.requesterImage,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            // currently creating swappables on the go, will give id and fetch it on swappable screen later.
            child: SwapSwappableCard(
              swappable: Swappable(
                id: swap.ownerItemId,
                name: swap.ownerItemName,
                imageUrls: swap.ownerItemImages,
                description: swap.ownerItemDescription,
                category: swap.ownerItemCategory,
                condition: swap.ownerItemCondition,
                createdAt: swap.ownerItemCreatedAt,
                updatedAt: swap.ownerItemUpdatedAt,
                ownerId: swap.ownerId,
                ownerName: swap.ownerName,
                ownerImageUrl: swap.ownerImage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

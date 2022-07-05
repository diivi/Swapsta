import 'package:flutter/material.dart';
import 'package:swapsta/models/swap.dart';
import 'package:swapsta/widgets/swap_swappable_card.dart';
import '../../globals.dart' as globals;
import '../models/swappable.dart';

class SentSwap extends StatefulWidget {
  const SentSwap({Key? key}) : super(key: key);

  @override
  State<SentSwap> createState() => _SentSwapState();
}

class _SentSwapState extends State<SentSwap> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    final Swap swap = globals.sentSwaps[0];
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          height: _dismissed ? 0 : MediaQuery.of(context).size.height * 0.315,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              color: Colors.red,
              clipBehavior: Clip.antiAlias,
              shadowColor: Colors.transparent,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 25.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ),
        Dismissible(
          onResize: () {
            setState(() {
              _dismissed = true;
            });
          },
          direction: DismissDirection.endToStart,
          key: Key(swap.id),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .315,
            child: Stack(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
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
                                categoryEmoji: swap.requesterItemCategoryEmoji,
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
                                categoryEmoji: swap.ownerItemCategoryEmoji,
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
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .44,
                      MediaQuery.of(context).size.height * .24,
                      0,
                      0),
                  child: Image.asset(
                    'assets/img/swap_arrow.png',
                    height: 35,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

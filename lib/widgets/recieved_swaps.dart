import 'package:flutter/material.dart';
import 'package:swapsta/widgets/swap_swappable_card.dart';
import '../../globals.dart' as globals;
import '../models/swap.dart';
import '../models/swappable.dart';

class SwapsRecieved extends StatefulWidget {
  const SwapsRecieved({
    Key? key,
    required this.tabSwitcher,
  }) : super(key: key);
  final TabController tabSwitcher;

  @override
  State<SwapsRecieved> createState() => _SwapsRecievedState();
}

class _SwapsRecievedState extends State<SwapsRecieved> {
  final Swap swap = globals.sentSwaps[0];

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            shadowColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red[400],
                          child: IconButton(
                              splashRadius: 24,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              splashColor: Colors.red[400],
                              highlightColor: Colors.transparent),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.orange[400],
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.contacts,
                                color: Colors.white,
                              ),
                              splashRadius: 24,
                              splashColor: Colors.orange[400],
                              highlightColor: Colors.transparent,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green[400],
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return AlertDialog(
                                        title: const Text('Swap Accepted'),
                                        content: Text(
                                            'You have accepted the swap request from ${swap.ownerName}'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                              widget.tabSwitcher.animateTo(2);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              splashRadius: 24,
                              splashColor: Colors.green[400],
                              highlightColor: Colors.transparent),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .44,
                MediaQuery.of(context).size.height * .24, 0, 0),
            child: Image.asset(
              'assets/img/swap_arrow.png',
              height: 35,
            ),
          )
        ],
      ),
    ]);
  }
}

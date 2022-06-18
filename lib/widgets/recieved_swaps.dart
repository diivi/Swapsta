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
                              id: '1',
                              name: 'Bag',
                              imageUrls: [
                                'https://m.media-amazon.com/images/I/51BPWfLZHFL._UX569_.jpg',
                                'https://m.media-amazon.com/images/I/51oGyFoRYPL.jpg'
                              ],
                              description: 'This is a swappable',
                              category: "Other",
                              categoryEmoji: '📚',
                              condition: 4,
                              createdAt: DateTime.now(),
                              ownerId: "7",
                              ownerName: "Shivansh Singh",
                              ownerImageUrl:
                                  "https://avatars.githubusercontent.com/u/89853707?v=4",
                              updatedAt: DateTime.now(),
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
                              id: '1',
                              name: 'Rain-Jacket',
                              imageUrls: [
                                'https://4.imimg.com/data4/KC/AS/MY-23240069/rain-jackets-500x500.jpg'
                              ],
                              description:
                                  'High Quality Nylon Polyester Blend Fabric with Water Resistance, Hood is rolled into the Collar of the Jacket.',
                              category: "Clothing",
                              categoryEmoji: '👕',
                              condition: 5,
                              createdAt: DateTime.now(),
                              ownerId: "7",
                              ownerName: "You",
                              ownerImageUrl:
                                  "https://avatars.githubusercontent.com/u/41837037?v=4",
                              updatedAt: DateTime.now(),
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
          Positioned(
            left: 0,
            right: 0,
            bottom: 80,
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

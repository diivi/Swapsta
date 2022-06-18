import 'package:flutter/material.dart';
import 'package:swapsta/widgets/swap_swappable_card.dart';
import '../../globals.dart' as globals;
import '../models/swap.dart';
import '../models/swappable.dart';

class SwapHistory extends StatelessWidget {
  const SwapHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Swap swap = globals.sentSwaps[0];
    return Wrap(children: [
      Stack(
        children: [
          Card(
            shadowColor: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
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
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
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
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      ' Swapped 19th June 2022',
                      style: TextStyle(color: Colors.orange),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Image.asset(
              'assets/img/done.png',
              height: 35,
            ),
          )
        ],
      ),
    ]);
  }
}

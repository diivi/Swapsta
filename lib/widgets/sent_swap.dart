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
                                id: '1',
                                name: 'Swappable 1',
                                imageUrls: ['https://picsum.photos/200/300'],
                                description: 'This is a swappable',
                                category: "Clothing",
                                categoryEmoji: '👕',
                                condition: 3.5,
                                createdAt: DateTime.now(),
                                ownerId: "7",
                                ownerName: "John Doe",
                                ownerImageUrl: "https://picsum.photos/400/300",
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
                                name: 'Swappable 1',
                                imageUrls: ['https://picsum.photos/400/300'],
                                description: 'This is a swappable',
                                category: "Clothing",
                                categoryEmoji: '👕',
                                condition: 3.5,
                                createdAt: DateTime.now(),
                                ownerId: "7",
                                ownerName: "John Doe",
                                ownerImageUrl: "https://picsum.photos/200/300",
                                updatedAt: DateTime.now(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 25,
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

import 'package:flutter/material.dart';
import 'package:swapsta/models/swap.dart';
import 'package:swapsta/widgets/swap_swappable_card.dart';
import '../../globals.dart' as globals;

class SentSwap extends StatelessWidget {
  const SentSwap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Swap swap = globals.sentSwaps[0];
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .2,
          width: double.infinity,
          child: Card(
            color: Colors.red,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: const [
                Icon(
                  (Icons.delete),
                ),
              ],
            ),
          ),
        ),
        Dismissible(
          key: Key(swap.id),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .2,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: const [
                  SwapSwappableCard(),
                  SwapSwappableCard(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

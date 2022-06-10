import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/providers/swappable.dart';
import 'condition.dart';

class SwappableCard extends StatelessWidget {
  const SwappableCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swappable = Provider.of<Swappable>(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(children: [
            Ink.image(
              fit: BoxFit.cover,
              image: NetworkImage(swappable.imageUrls[0]),
              height: 160,
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  splashRadius: 15,
                  onPressed: () {
                    swappable.toggleWishlist();
                  },
                  icon: swappable.isWishlisted
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  color: Colors.orange,
                ))
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  swappable.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                              NetworkImage(swappable.ownerImageUrl),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            swappable.ownerName,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    )),
                //condition
                ConditionStars(swappable.condition),
              ],
            ),
          )
        ],
      ),
    );
  }
}

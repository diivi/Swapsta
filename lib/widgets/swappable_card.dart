import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/providers/swappable_provider.dart';
import '../providers/auth_provider.dart';
import '../screens/swappable_screen.dart';
import 'condition.dart';

class SwappableCard extends StatelessWidget {
  const SwappableCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swappable = Provider.of<Swappable>(context);
    final user = Provider.of<Auth>(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        splashColor: const Color(0x50FF8E3C),
        highlightColor: const Color(0x00ffffff),
        onTap: () {
          Navigator.of(context)
              .pushNamed(SwappableScreen.routeName, arguments: swappable);
        },
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'swappable-${swappable.id}',
                  child: Material(
                    child: Ink.image(
                      fit: BoxFit.cover,
                      image: NetworkImage(swappable.imageUrls[0]),
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      splashRadius: 15,
                      onPressed: () {
                        user.toggleWishlist(swappable.id);
                      },
                      icon: user.wishlist.containsKey(swappable.id)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                      color: Colors.orange,
                    ))
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .115,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    swappable.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * .035,
                        backgroundImage: NetworkImage(swappable.ownerImageUrl),
                      ),
                      const SizedBox(width: 5),
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
                  ),
                  //condition
                  ConditionStars(swappable.condition),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

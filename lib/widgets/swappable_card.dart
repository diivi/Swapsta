import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/swappables_provider.dart';
import 'condition.dart';

class SwappableCard extends StatelessWidget {
  const SwappableCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.ownerName,
      required this.ownerImageUrl,
      required this.imageUrls,
      required this.condition,
      required this.isWishlisted})
      : super(key: key);

  final String id;
  final String name;
  final String ownerName;
  final String ownerImageUrl;
  final List<String> imageUrls;
  final bool isWishlisted;
  final double condition;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Ink.image(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrls[0]),
              height: 160,
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: isWishlisted
                    ? IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          Provider.of<Swappables>(context, listen: false)
                              .toggleWishlist(id);
                        },
                        icon: const Icon(Icons.favorite),
                        color: Colors.orange,
                      )
                    : IconButton(
                        splashRadius: 15,
                        onPressed: () {
                          Provider.of<Swappables>(context, listen: false)
                              .toggleWishlist(id);
                        },
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.orange,
                      ))
          ]),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
              child: Row(
                children: [
                  //circle avatar dp
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(ownerImageUrl),
                  ),
                  //owner name
                  const SizedBox(width: 10),
                  Text(
                    ownerName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )),
          //condition
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ConditionStars(condition),
          )
        ],
      ),
    );
  }
}

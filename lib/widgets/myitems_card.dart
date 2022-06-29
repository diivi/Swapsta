import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/swappable.dart';
import '../providers/auth_provider.dart';
import '../screens/swappable_screen.dart';
import 'condition.dart';

class MyItemsCard extends StatelessWidget {
  final Swappable swappable;

  const MyItemsCard({
    Key? key,
    required this.swappable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
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
                    child: Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(swappable.imageUrls[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * .2,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.transparent,
                    child: const Icon(Icons.edit),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Material(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.transparent,
                      child: ConditionStars(swappable.condition)),
                )
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
                          (swappable.ownerId == user.id)
                              ? "You"
                              : swappable.ownerName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                  //condition

                  Text('Swap Requests: ${swappable.swapRequests}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

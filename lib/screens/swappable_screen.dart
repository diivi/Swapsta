import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:swapsta/widgets/condition.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/swappable_provider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';

class SwappableScreen extends StatelessWidget {
  static const routeName = '/swappable';

  const SwappableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    final swappable = routeArgs as Swappable;
    //formatting swappable.updatedAt
    String formattedDate =
        DateFormat('dd MMMM y ,').add_jm().format(swappable.updatedAt);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.orange),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Hero(
              tag: 'swappable-${swappable.id}',
              child: ImageSlideshow(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                initialPage: 0,
                indicatorColor: Colors.orange,
                isLoop: swappable.imageUrls.length > 1,
                autoPlayInterval: 4000,
                children: swappable.imageUrls
                    .map(
                      (url) => Stack(
                        children: [
                          Image.network(
                            url,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.7),
                                  blurRadius: 30,
                                  spreadRadius: 0,
                                  offset: const Offset(0, -30),
                                  inset: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      swappable.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Row(
                    //avatar
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(swappable.ownerImageUrl),
                      ),

                      const SizedBox(width: 10),
                      //ownername
                      Text(
                        (swappable.ownerId == user.id)
                            ? "You"
                            : swappable.ownerName,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const Spacer(),

                      //category pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              swappable.categoryEmoji,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              swappable.category,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  //description
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      swappable.description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Spacer(),

                  //condition
                  Row(
                    children: [
                      const Text(
                        'Condition: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      ConditionStars(swappable.condition)
                    ],
                  ),
                  //buttons
                  Container(
                      child: (swappable.ownerId != user.id)
                          ? Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      user.toggleWishlist(swappable.id);
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: (!user.wishlist
                                            .containsKey(swappable.id))
                                        ? buildButton(
                                            context: context,
                                            wishlist: false,
                                          )
                                        : buildButton(
                                            context: context,
                                            wishlist: true,
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.orange,
                                        ),
                                        color: Colors.orange,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.swap_horiz,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      'Request Swap',
                                                      overflow:
                                                          TextOverflow.fade,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : (null)
                      //swap button
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Last updated at ' + formattedDate,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildButton({
  required BuildContext context,
  required bool wishlist,
}) {
  return InkWell(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: wishlist ? Colors.orange : const Color(0xFFF9F6F2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: wishlist ? const Color(0xFFF9F6F2) : Colors.orange,
          width: 2,
        ),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              wishlist ? Icons.favorite : Icons.favorite_border,
              color: wishlist ? Colors.white : Colors.orange,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wishlist ? 'Saved' : 'Wishlist',
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: wishlist ? Colors.white : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

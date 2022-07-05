import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:swapsta/providers/screen_provider.dart';
import 'package:swapsta/screens/image_screen.dart';
import 'package:swapsta/widgets/condition.dart';
import 'package:swapsta/widgets/swap_dialog.dart';
import 'package:provider/provider.dart';
import '../models/swappable.dart';
import '../providers/auth_provider.dart';
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
                      (url) => GestureDetector(
                        onTap: () {
                          Navigator.push<Widget>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageScreen(
                                url: swappable.imageUrls,
                              ),
                            ),
                          );
                        },
                        child: Stack(
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

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  //description
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: SingleChildScrollView(
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Spacer(),
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
                                  buildSwappableButton(
                                    context: context,
                                    wishlist: (user.wishlist
                                            .containsKey(swappable.id))
                                        ? true
                                        : false,
                                    onPressed: () {
                                      user.toggleWishlist(swappable.id);
                                    },
                                  ),
                                  Material(
                                    child: Ink(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: Colors.orange,
                                        ),
                                        color: Colors.orange,
                                      ),
                                      child: InkWell(
                                        splashColor: const Color.fromRGBO(
                                          255,
                                          255,
                                          255,
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  SwapDialog());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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

Widget buildSwappableButton({
  required BuildContext context,
  required bool wishlist,
  required Function onPressed,
}) {
  return Material(
    color: Colors.transparent,
    child: Ink(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: wishlist ? Colors.orange : const Color(0xFFF9F6F2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: wishlist ? Colors.transparent : Colors.orange,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
        highlightColor: Colors.transparent,
        onTap: (() => onPressed()),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
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
    ),
  );
}

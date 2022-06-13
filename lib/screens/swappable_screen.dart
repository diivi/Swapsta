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
        DateFormat('dd-MM-yyyy, hh:mm a').format(swappable.updatedAt);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Hero(
            tag: 'swappable-${swappable.id}',
            child: ImageSlideshow(
              width: double.infinity,
              height: 300,
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
                          height: 300,
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
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            width: double.infinity,
            child: Column(
              children: [
                //swappable name
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    swappable.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  //avatar
                  children: [
                    CircleAvatar(
                      radius: 15,
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
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black12,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Text(swappable.categoryEmoji),
                          const SizedBox(width: 5),
                          Text(swappable.category)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                //description
                SizedBox(
                  width: double.infinity,
                  child: Text(swappable.description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54)),
                ),
                const SizedBox(height: 10),

                //condition
                Row(
                  children: [
                    const Text(
                      'Condition: ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54),
                    ),
                    ConditionStars(swappable.condition)
                  ],
                ),

                //buttons
                Container(
                    child: (swappable.ownerId != user.id)
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.favorite_outline,
                                            color: Colors.black54),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Wishlist',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 10,
                                // ),
                                InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.orange,
                                      ),
                                      color: Colors.orange,
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.swap_horiz,
                                            color: Colors.white),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Request Swap',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )
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
    );
  }
}

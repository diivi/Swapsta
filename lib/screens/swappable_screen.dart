
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
                    (swappable.ownerId == user.id)
                        ? const Text(
                            "You",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        : Text(
                            swappable.ownerName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
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
                // const SizedBox(height: 20),

                //buttons
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: (swappable.ownerId != user.id)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  user.toggleWishlist(swappable.id);
                                },
                                borderRadius: BorderRadius.circular(30),
                                child: (!user.wishlist.containsKey(swappable.id)) ? 
                                buildButton(context: context,width: 2, bordercColor: Colors.orange, textDisplay: 'Wishlist', displayIcon: Icons.favorite_border_outlined, contentColor: Colors.black54 , boxColor: Color(0xFFF9F6F2)) :
                                buildButton(context: context,width: 0, bordercColor: Colors.white, textDisplay: 'Saved', displayIcon: Icons.favorite, contentColor: Colors.white , boxColor: Colors.orange),
                                
                              ),
                              InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(30),
                                child: //buildButton(width: 0, bordercColor: Colors.orange, textDisplay: 'Request Swap', displayIcon : Icons.swap_horiz, contentColor: Colors.white, boxColor: Colors.orange) 
                                Container(
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

Widget buildButton({
  required BuildContext context,
  required double width,
  required Color bordercColor,
  required String textDisplay,
  required IconData displayIcon,
  required Color contentColor,
  required Color boxColor,
}) {
  return Container(
    width: 150,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: boxColor,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: bordercColor,
        width: width,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(displayIcon ,color: contentColor),    
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textDisplay,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: contentColor),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

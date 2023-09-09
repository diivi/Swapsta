import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swappable.dart';
import 'package:uuid/uuid.dart';
import '../widgets/swap_dialog_card.dart';

class SwapDialog extends StatefulWidget {
  const SwapDialog({
    Key? key,
    required this.swappableItem,
  }) : super(key: key);
  final Swappable swappableItem;
  @override
  State<SwapDialog> createState() => _SwapDialog();
}

class _SwapDialog extends State<SwapDialog> {
  int optionSelected = 0;

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;
    var item_id = Uuid().v4();
    Future<void> addSwapToDatabase(Swappable requesterItem) async {
      final firestore = FirebaseFirestore.instance;
      // final userId = authUser.email;
      final swapDocument = firestore.collection('swaps').doc(item_id);
      // final userDocument = firestore.collection('users').doc(userId);
      final ownerItem =
          firestore.collection('items').doc(widget.swappableItem.id);
      final requestItem = firestore.collection('items').doc(requesterItem.id);
      // final ownerDocument =
      //     firestore.collection('users').doc(widget.swappableItem.ownerId);
      final newItem = {
        'id': item_id,
        'requesterId': authUser.email,
        'requesterName': authUser.displayName,
        'requesterImage': authUser.photoURL,
        'requesterPhone': authUser.phoneNumber,
        'ownerId': widget.swappableItem.ownerId,
        'ownerName': widget.swappableItem.ownerName,
        'ownerImage': widget.swappableItem.ownerImageUrl,
        'status': 'requested',
        'requestItemId': requesterItem.id,
        'requesterItemId': requesterItem.id, // Add requester item ID
        'requesterItemName': requesterItem.name,
        'requesterItemImages': requesterItem.imageUrls,
        'requesterItemDescription': requesterItem.description,
        'requesterItemCategory': requesterItem.category,
        'requesterItemCreatedAt': requesterItem.createdAt.toIso8601String(),
        'requesterItemUpdatedAt': requesterItem.updatedAt.toIso8601String(),
        'requesterItemCondition': requesterItem.condition,
        'requesterItemCategoryEmoji': requesterItem.categoryEmoji,
        'ownerItemId': widget.swappableItem.id,
        'ownerItemName': widget.swappableItem.name,
        'ownerItemImages': widget.swappableItem.imageUrls,
        'ownerItemDescription': widget.swappableItem.description,
        'ownerItemCategory': widget.swappableItem.category,
        'ownerItemCreatedAt': widget.swappableItem.createdAt.toIso8601String(),
        'ownerItemUpdatedAt': widget.swappableItem.updatedAt.toIso8601String(),
        'ownerItemCondition': widget.swappableItem.condition,
        'ownerItemCategoryEmoji': widget.swappableItem.categoryEmoji,
      };
      try {
        await swapDocument.set(newItem);
        await ownerItem.update({
          'swapRequests': widget.swappableItem.swapRequests! + 1,
        });
        await requestItem.update({
          'swapRequests': requesterItem.swapRequests! + 1,
        });
      } on Exception catch (e) {
        print(e);
      }
    }

    final swappableProvider = Provider.of<SwappableProvider>(context);
    final swappables = swappableProvider.swappables;
    final isFetching = swappableProvider.isFetching;
    final filteredSwappables = swappables
        .where((swappable) => swappable.ownerId == authUser.email)
        .toList();
    return AlertDialog(
      backgroundColor: Color.fromRGBO(249, 246, 242, 1),
      // contentPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select your Item'),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
            highlightColor: const Color(0x00ffffff),
            child: Icon(
              Icons.close,
              color: Color.fromRGBO(255, 152, 0, 1),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),

      content: (!isFetching)
          ? Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .8,
              child: Stack(alignment: Alignment.center, children: [
                GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0.0),
                  itemCount: filteredSwappables.length + 1,
                  controller: ScrollController(),
                  itemBuilder: (ctx, i) {
                    if (i == 0) {
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color.fromRGBO(255, 142, 60, 0.7),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            iconSize: 50,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/add-item',
                              );
                            },
                          ));
                    }
                    return SelectItemCard(
                      swappable: filteredSwappables[i - 1],
                      onTap: () => checkOption(i + 1),
                      selected: i + 1 == optionSelected,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.35),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
                Positioned.fill(
                  bottom: 20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        'Choose Item',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (optionSelected != 0) {
                          try {
                            showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // Prevent dismissing the dialog by tapping outside
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircularProgressIndicator(), // Show the circular progress indicator
                                      SizedBox(height: 16),
                                      Text(
                                        "Please wait...",
                                      ), // Optional: Add a message
                                    ],
                                  ),
                                );
                              },
                            );
                            await addSwapToDatabase(
                              filteredSwappables[optionSelected - 2],
                            );
                          } on Exception catch (e) {
                            print(e);
                            Navigator.pop(context);
                          }
                          Navigator.pop(context);
                          final swappableProvider =
                              Provider.of<SwappableProvider>(
                            context,
                            listen: false,
                          );
                          swappableProvider.fetchSwaps();
                          Navigator.popAndPushNamed(context, '/home');
                          // print(filteredSwappables[optionSelected - 2]);
                        } else {
                          null;
                        }
                      },
                    ),
                  ),
                ),
              ]),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

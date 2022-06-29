import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swap.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/providers/recieved_swap_provider.dart';
import 'package:swapsta/widgets/swap_swappable_row.dart';

class RecievedSwapGrid extends StatefulWidget {
  final String searchQuery;
  final TabController tabSwitcher;


  const RecievedSwapGrid({Key? key, required this.searchQuery, required this.tabSwitcher})
      : super(key: key);

  @override
  State<RecievedSwapGrid> createState() => _RecievedSwapGridState();
}

class _RecievedSwapGridState extends State<RecievedSwapGrid> {
  @override
  Widget build(BuildContext context) {
    final List<Swap> recievedSwapList =
        Provider.of<RecievedSwap>(context).recievedSwaps;

    final keywordIncludedSwappables = recievedSwapList
        .where((recievedSwap) =>
            recievedSwap.ownerItemDescription
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.ownerItemName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.ownerName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.ownerPhone!
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.ownerItemCategory
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.requesterItemCategory
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.requesterItemDescription
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.requesterItemName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.requesterName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            recievedSwap.requesterPhone
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()))
        .toList();
    final ScrollController scrollController = ScrollController();

    return Consumer<BottomBarVisibilityProvider>(
      builder: (context, bottomBarVisibilityProvider, child) {
        scrollController.addListener(() {
          final direction = scrollController.position.userScrollDirection;

          if (direction == ScrollDirection.forward) {
            if (!bottomBarVisibilityProvider.isVisible) {
              bottomBarVisibilityProvider.show();
            }
          } else if (direction == ScrollDirection.reverse) {
            if (bottomBarVisibilityProvider.isVisible) {
              bottomBarVisibilityProvider.hide();
            }
          }
        });
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          itemCount: keywordIncludedSwappables.length,
          controller: scrollController,
          itemBuilder: (ctx, i) {
            return Wrap(children: [
              Stack(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    shadowColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          SwapSwappableRow(swap: keywordIncludedSwappables[i]),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.red[400],
                                  child: IconButton(
                                      splashRadius: 24,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                      splashColor: Colors.red[400],
                                      highlightColor: Colors.transparent),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.orange[400],
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.contacts,
                                        color: Colors.white,
                                      ),
                                      splashRadius: 24,
                                      splashColor: Colors.orange[400],
                                      highlightColor: Colors.transparent,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.green[400],
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Swap Accepted'),
                                                content: Text(
                                                    'You have accepted the swap request from ${keywordIncludedSwappables[i].ownerName}'),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                      widget.tabSwitcher
                                                          .animateTo(2);
                                                    },
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      splashRadius: 24,
                                      splashColor: Colors.green[400],
                                      highlightColor: Colors.transparent),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 80,
                    child: Image.asset(
                      'assets/img/swap_arrow.png',
                      height: 35,
                    ),
                  )
                ],
              ),
            ]);
          },
        );
      },
    );
  }
}

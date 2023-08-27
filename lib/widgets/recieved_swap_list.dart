import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swappable.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/widgets/swap_swappable_row.dart';

class recievedswapslist extends StatefulWidget {
  final String searchQuery;
  final TabController tabSwitcher;

  const recievedswapslist(
      {Key? key, required this.searchQuery, required this.tabSwitcher})
      : super(key: key);

  @override
  State<recievedswapslist> createState() => _recievedswapslistState();
}

class _recievedswapslistState extends State<recievedswapslist> {
  @override
  Widget build(BuildContext context) {
    final swappableProvider = Provider.of<SwappableProvider>(context);
    final rSwaps = swappableProvider.recievedSwaps;

    final keywordIncludedSwaps = rSwaps
        .where((recievedSwap) =>
            recievedSwap.ownerName
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
          itemCount: keywordIncludedSwaps.length,
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
                          SwapSwappableRow(swap: keywordIncludedSwaps[i]),
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
                                                    'You have accepted the swap request from ${keywordIncludedSwaps[i].ownerName}'),
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
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .41,
                        MediaQuery.of(context).size.height * .24,
                        0,
                        0),
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

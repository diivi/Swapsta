import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swappable.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/widgets/swap_swappable_row.dart';

class swaphistorylist extends StatefulWidget {
  final String searchQuery;

  const swaphistorylist({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  State<swaphistorylist> createState() => _swaphistorylistState();
}

class _swaphistorylistState extends State<swaphistorylist> {
  @override
  Widget build(BuildContext context) {
    String formatDate(String d) {
      DateTime dt = DateTime.parse(d);
      String formattedDate = DateFormat('d MMMM, y').format(dt);
      return formattedDate;
    }

    final swappableProvider = Provider.of<SwappableProvider>(context);
    final histSwaps = swappableProvider.historySwap;

    final keywordIncludedSwaps = histSwaps
        .where((sentSwap) =>
            sentSwap.ownerName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.requesterName
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
                    shadowColor: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          SwapSwappableRow(
                            swap: keywordIncludedSwaps[i],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Completed Swap on ' +  formatDate(keywordIncludedSwaps[i].createdAt.toString()),
                              style: TextStyle(color: Colors.orange),
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
                      'assets/img/done.png',
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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swap.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/providers/swap_history_provider.dart';
import 'package:swapsta/widgets/swap_swappable_row.dart';

class SwapHistoryGrid extends StatefulWidget {
  final String searchQuery;

  const SwapHistoryGrid({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  State<SwapHistoryGrid> createState() => _SwapHistoryGridState();
}

class _SwapHistoryGridState extends State<SwapHistoryGrid> {
  @override
  Widget build(BuildContext context) {
    final List<Swap> swapHistoryList =
        Provider.of<SwapHistory>(context).swapHistory;

    final keywordIncludedSwappables = swapHistoryList
        .where((sentSwap) =>
            sentSwap.ownerItemDescription
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.ownerItemName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.ownerName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.ownerPhone!
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.ownerItemCategory
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.requesterItemCategory
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.requesterItemDescription
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.requesterItemName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.requesterName
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()) ||
            sentSwap.requesterPhone
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
                            swap: keywordIncludedSwappables[i],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              ' Swapped 19th June 2022',
                              style: TextStyle(color: Colors.orange),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
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

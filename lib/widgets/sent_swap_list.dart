import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swappable.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/widgets/swap_swappable_row.dart';

class sentswapslist extends StatefulWidget {
  final String searchQuery;

  const sentswapslist({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<sentswapslist> createState() => _sentswapslistState();
}

class _sentswapslistState extends State<sentswapslist> {
  bool _dismissed = false;
  @override
  Widget build(BuildContext context) {
    final swappableProvider = Provider.of<SwappableProvider>(context);
    final sentSwaps = swappableProvider.sentSwaps;

    // final List<Swap> sentSwapList = Provider.of<SentSwap>(context).sentSwaps;

    final keywordIncludedSwaps = sentSwaps
        .where((sentSwap) =>
            sentSwap!.ownerName
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
        // final swappableProvider = Provider.of<SwappableProvider>(
        //   context,
        //   listen: false,
        // );
        // final sentSwaps = swappableProvider.sentSwaps;
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10.0),
          itemCount: keywordIncludedSwaps.length,
          controller: scrollController,
          itemBuilder: (ctx, i) {
            return Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 50),
                  height: _dismissed
                      ? 0
                      : MediaQuery.of(context).size.height * 0.315,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.red,
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.transparent,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 25.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Dismissible(
                  onResize: () {
                    setState(() {
                      _dismissed = true;
                    });
                  },
                  direction: DismissDirection.endToStart,
                  key: Key(keywordIncludedSwaps[i]!.id),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .315,
                    child: Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child:
                                SwapSwappableRow(swap: keywordIncludedSwaps[i]),
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
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

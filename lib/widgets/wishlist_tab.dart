import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/swappable.dart';
import '../providers/bottom_nav_visibility_provider.dart';
import 'swappable_card.dart';

class WishlistTab extends StatelessWidget {
  WishlistTab({
    Key? key,
    required this.wishlistedSwappables,
  }) : super(key: key);

  final List<Swappable> wishlistedSwappables;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
      return GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        itemCount: wishlistedSwappables.length,
        controller: scrollController,
        itemBuilder: (ctx, i) {
          return SwappableCard(
            swappable: wishlistedSwappables[i],
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 1.4),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../models/swappable.dart';
import '../providers/bottom_nav_visibility_provider.dart';
import '../screens/add_item_screen.dart';
import 'myitems_card.dart';

class MyItems extends StatelessWidget {
  MyItems({
    Key? key,
    required this.mySwappables,
  }) : super(key: key);

  final List<Swappable> mySwappables;
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

      return Stack(
        fit: StackFit.expand,
        children: [
          GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: mySwappables.length,
            controller: scrollController,
            itemBuilder: (ctx, i) {
              return MyItemsCard(
                swappable: mySwappables[i],
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.4),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.19,
            right: 25,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddItemScreen.routeName);
                },
                icon: const Icon(Icons.add),
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
      // return GridView.builder(
      //   physics: const BouncingScrollPhysics(),
      //   padding: const EdgeInsets.all(10.0),
      //   itemCount: mySwappables.length,
      //   controller: scrollController,
      //   itemBuilder: (ctx, i) {
      //     return MyItemsCard(
      //       swappable: mySwappables[i],
      //     );
      //   },
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     childAspectRatio: MediaQuery.of(context).size.width /
      //         (MediaQuery.of(context).size.height / 1.4),
      //     crossAxisSpacing: 10,
      //     mainAxisSpacing: 10,
      //   ),
      // );
    });
  }
}

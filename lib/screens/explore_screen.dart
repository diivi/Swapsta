import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:swapsta/widgets/pills.dart';
import '../widgets/swappable_card.dart';
import '../../globals.dart' as globals;

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);
  final swappablesList = globals.swappables;
  final categories = globals.categories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: Column(
          children: [
            Container(
              height: 50,
              
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (ctx, i) {
                  return Pills(name: categories[i].name, emoji: categories[i].emoji); // return category pill widget here
                },
                scrollDirection: Axis.horizontal,
                
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: swappablesList.length,
                itemBuilder: (ctx, i) => SwappableCard(
                  id: swappablesList[i].id,
                  name: swappablesList[i].name,
                  ownerName: swappablesList[i].ownerName,
                  ownerImageUrl: swappablesList[i].ownerImageUrl,
                  imageUrls: swappablesList[i].imageUrls,
                  condition: swappablesList[i].condition,
                  isWishlisted: swappablesList[i].isWishlisted,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

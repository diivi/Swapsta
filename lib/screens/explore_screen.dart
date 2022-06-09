import 'package:flutter/material.dart';
import '../widgets/swappable_card.dart';
import '../../globals.dart' as globals;

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);
  final swappablesList = globals.swappables;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
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
    );
  }
}

import 'package:flutter/material.dart';
import '../providers/swappables_provider.dart';
import '../widgets/swappable_card.dart';
import 'package:provider/provider.dart';

class SwappablesGrid extends StatelessWidget {
  const SwappablesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swappablesData = Provider.of<Swappables>(context);
    final swappablesList = swappablesData.swappables;

    return GridView.builder(
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
    );
  }
}

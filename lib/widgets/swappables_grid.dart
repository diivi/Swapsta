import 'package:flutter/material.dart';
import '../providers/swappables_provider.dart';
import '../widgets/swappable_card.dart';
import 'package:provider/provider.dart';

class SwappablesGrid extends StatelessWidget {
  final String filter;
  const SwappablesGrid({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swappablesData = Provider.of<Swappables>(context);
    final swappablesList = swappablesData.swappables;

    final filteredSwappables = filter == 'All Categories'
        ? swappablesList
        : swappablesList
            .where((swappable) => swappable.category == filter)
            .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: filteredSwappables.length,
      itemBuilder: (ctx, i) => SwappableCard(
        id: filteredSwappables[i].id,
        name: filteredSwappables[i].name,
        ownerName: filteredSwappables[i].ownerName,
        ownerImageUrl: filteredSwappables[i].ownerImageUrl,
        imageUrls: filteredSwappables[i].imageUrls,
        condition: filteredSwappables[i].condition,
        isWishlisted: filteredSwappables[i].isWishlisted,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.67,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}

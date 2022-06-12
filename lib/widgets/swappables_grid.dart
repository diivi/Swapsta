import 'package:flutter/material.dart';
import 'package:swapsta/providers/swappable_provider.dart';
import 'package:swapsta/widgets/sort_modal.dart';
import '../providers/swappables_provider.dart';
import '../widgets/swappable_card.dart';
import 'package:provider/provider.dart';

class SwappablesGrid extends StatelessWidget {
  final String filter;
  final String searchQuery;
  final Sort order;
  const SwappablesGrid(
      {Key? key,
      required this.filter,
      required this.searchQuery,
      required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final swappablesList = Provider.of<Swappables>(context).swappables;
    final categoryWiseSwappables = filter == 'All Categories'
        ? swappablesList
        : swappablesList
            .where((swappable) => swappable.category == filter)
            .toList();
    final keywordIncludedSwappables = categoryWiseSwappables
        .where((swappable) =>
            swappable.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            swappable.description
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            swappable.ownerName
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();

    final sortedSwappables = sortSwappables(keywordIncludedSwappables, order);

    final filteredSwappables = sortedSwappables;

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: filteredSwappables.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: filteredSwappables[i],
        child: const SwappableCard(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.4),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

List<Swappable> sortSwappables(List<Swappable> swappables, Sort order) {
  switch (order) {
    case Sort.added:
      swappables.sort((a, b) => -1 * a.createdAt.compareTo(b.createdAt));
      break;
    case Sort.updated:
      swappables.sort((a, b) => -1 * a.createdAt.compareTo(b.createdAt));
      break;
    case Sort.condition:
      swappables.sort((a, b) => -1 * a.condition.compareTo(b.condition));
      break;
  }
  return swappables;
}

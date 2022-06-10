import 'package:flutter/material.dart';
import 'package:swapsta/providers/swappable.dart';
import '../providers/swappables_provider.dart';
import '../widgets/swappable_card.dart';
import 'package:provider/provider.dart';

class SwappablesGrid extends StatelessWidget {
  final String filter;
  final String searchQuery;
  const SwappablesGrid(
      {Key? key, required this.filter, required this.searchQuery})
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

    // TODO:  sort these keyword included swappables by sort order;
    final filteredSwappables = keywordIncludedSwappables;

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: filteredSwappables.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: filteredSwappables[i],
        child: const SwappableCard(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.67,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

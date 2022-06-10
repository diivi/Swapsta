import 'package:flutter/material.dart';
import 'package:swapsta/widgets/pill.dart';
import '../../globals.dart' as globals;
import '../widgets/home_header.dart';
import '../widgets/swappables_grid.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final categories = globals.categories;

  String selectedFilter = 'All Categories';

  void _onFilterChanged(String value) {
    setState(() {
      selectedFilter = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 50,
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (ctx, i) {
              return Pill(
                name: categories[i].name,
                emoji: categories[i].emoji,
                handleTap: () {
                  _onFilterChanged(categories[i].name);
                },
                active: selectedFilter == categories[i].name,
              ); // return category pill widget here
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Expanded(
          child: SwappablesGrid(
            filter: selectedFilter,
          ),
        ),
      ],
    );
  }
}

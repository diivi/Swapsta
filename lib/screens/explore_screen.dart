import 'package:flutter/material.dart';
import 'package:swapsta/widgets/pill.dart';
import '../../globals.dart' as globals;
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/sort_button.dart';
import '../widgets/sort_modal.dart';
import '../widgets/swappables_grid.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final categories = globals.categories;

  String selectedFilter = 'All Categories';
  String searchQuery = '';
  Sort sort = Sort.added;

  void _onFilterChanged(String value) {
    setState(() {
      selectedFilter = value;
    });
  }

  void _onSearchQueryChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  void _onSortChanged(Sort value) {
    setState(() {
      sort = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Flexible(
                child: SearchBox(
                  handleSearch: (String value) {
                    _onSearchQueryChanged(value);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10),
          height: 50,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
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
          child: Stack(
            children: [
              SwappablesGrid(
                filter: selectedFilter,
                searchQuery: searchQuery,
                order: sort,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

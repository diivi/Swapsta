import 'package:flutter/material.dart';
import 'package:swapsta/widgets/pill.dart';
import '../../globals.dart' as globals;
import '../widgets/home_header.dart';
import '../widgets/swappables_grid.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);
  final categories = globals.categories;

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
                  emoji:
                      categories[i].emoji); // return category pill widget here
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        const Expanded(
          child: SwappablesGrid(),
        ),
      ],
    );
  }
}

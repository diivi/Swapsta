import 'package:flutter/material.dart';
import 'search_box.dart';

class SwapscreenHeader extends StatelessWidget {
  const SwapscreenHeader({Key? key, required this.handleSearch}) : super(key: key);
  final Function(String) handleSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'SwapScreen',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: SearchBox(
                handleSearch: handleSearch,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}

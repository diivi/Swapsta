import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.sort_rounded,
      color: Colors.orange,
    );
  }
}

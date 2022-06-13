import 'package:flutter/material.dart';
import 'package:swapsta/widgets/sort_modal.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
    required this.handleSortSelection,
    required this.selectedSort,
  }) : super(key: key);

  final void Function(Sort) handleSortSelection;
  final Sort selectedSort;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.sort_rounded,
        color: Colors.orange,
      ),
      onPressed: () => showSortModal(
        context,
        selectedSort,
        handleSortSelection,
      ),
      splashRadius: 26,
      splashColor: const Color.fromRGBO(255, 152, 0, 0.3),
    );
  }
}

import 'package:flutter/material.dart';

enum Sort { condition, updated, added }

Future<dynamic> showSortModal(
    BuildContext context, Sort current, void Function(Sort) onSortChanged) {
  var options = [
    {
      'value': Sort.condition,
      'label': 'Condition: High to Low',
      'icon': Icons.align_vertical_bottom_rounded,
    },
    {
      'value': Sort.updated,
      'label': 'Recently updated',
      'icon': Icons.av_timer_rounded
    },
    {
      'value': Sort.added,
      'label': 'Recently added',
      'icon': Icons.bolt_rounded
    },
  ];

  return showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: ((context, setState) {
          void handleSortSelection(Sort value) {
            onSortChanged(value);
            setState(() {
              current = value;
            });
          }

          return Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sort by',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 20),
                Column(
                    children: options.map((option) {
                  return _buildListItem(
                    context,
                    title: option['label'].toString(),
                    icon: option['icon'] as IconData,
                    value: option['value'] as Sort,
                    selected: current == option['value'],
                    onTap: () {
                      handleSortSelection(option['value'] as Sort);
                    },
                  );
                }).toList())
              ],
            ),
          );
        }),
      );
    },
  );
}

Widget _buildListItem(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Sort value,
  required bool selected,
  required Function onTap,
}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Icon(icon, color: Colors.orange),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
      const Spacer(),
      Radio(
        value: value,
        groupValue: selected ? value : null,
        onChanged: (value) {
          onTap();
        },
      ),
    ],
  );
}

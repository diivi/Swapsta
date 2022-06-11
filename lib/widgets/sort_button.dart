import 'package:flutter/material.dart';

enum Sort {
  hightolow,
  updatedrecently,
  addednow,
}

class SortButton extends StatefulWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  Widget _buildListItem(
    BuildContext context, {
    required Widget title,
    required Widget leading,
    required Widget trailing,
  }) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (leading != null) leading,
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: title,
              ),
            const Spacer(),
            if (trailing != null) trailing,
          ],
        ));
  }

  String _current = 'hightolow';
  @override
  Widget build(BuildContext context) {
    void _handlePressed() {
      showModalBottomSheet(
        shape : const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sort by' , style: TextStyle(fontSize: 20),),
                _buildListItem(
                  context,
                  title: const Text('Condition :- High to Low'),
                  leading: const Icon(
                    Icons.align_vertical_bottom_rounded,
                    color: Colors.orange,
                  ),
                  trailing: Radio<String>(
                      value: 'hightolow',
                      groupValue: _current,
                      toggleable: true,
                      onChanged: (value) {
                        setState(() {
                          _current = value!;
                        });
                      }),
                ),
                _buildListItem(
                  context,
                  title: const Text('Recently Updated'),
                  leading: const Icon(
                    Icons.av_timer_rounded,
                    color: Colors.orange,
                  ),
                  trailing: Radio<String>(
                      value: 'recently',
                      groupValue: _current,
                      toggleable: true,
                      onChanged: (value) {
                        setState(() {
                          _current = value!;
                        });
                      }),
                ),
                _buildListItem(
                  context,
                  title: const Text('Recently Added'),
                  leading: const Icon(
                    Icons.bolt_rounded,
                    color: Colors.orange,
                  ),
                  trailing: Radio<String>(
                      value: 'addednow',
                      groupValue: _current,
                      toggleable: true,
                      onChanged: (value) {
                        setState(() {
                          _current = value!;
                        });
                      }),
                ),
              ],
            ),
          );
        },
      );
    }

    return IconButton(
      icon: const Icon(
        Icons.sort_rounded,
        color: Colors.orange,
      ),
      onPressed: _handlePressed,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_box.dart';
import '../providers/auth_provider.dart';

class SwapscreenHeader extends StatelessWidget {
  const SwapscreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
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
                handleSearch: (String value) {},
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

import 'package:flutter/material.dart';
// import '../../globals.dart' as globals;

class Pills extends StatelessWidget {
  // final categories = globals.categories;
  final String name;
  final String emoji;
  const Pills({Key? key, required this.name, required this.emoji})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 42,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 124,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            emoji,
          ),
          Text(name ,overflow : TextOverflow.fade)
        ],
      ),
    );
  }
}

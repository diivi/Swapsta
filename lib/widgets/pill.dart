import 'package:flutter/material.dart';
// import '../../globals.dart' as globals;

class Pill extends StatelessWidget {
  final String name;
  final String emoji;
  final Function handleTap;
  final bool active;
  const Pill(
      {Key? key,
      required this.name,
      required this.emoji,
      required this.handleTap,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Color.fromARGB(126, 29, 29, 28),
        onTap: () {
          handleTap();
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: active ? Colors.black : Color(0xFFF4F6FB),
          ),
          width: 124,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  name,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 16,
                    color: active ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

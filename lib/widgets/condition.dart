import 'package:flutter/material.dart';

//doesnt display half stars rn
class ConditionStars extends StatelessWidget {
  final double rating;
  const ConditionStars(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int starCounter = 0;
    return Row(
      children: [
        //print filled stars
        for (var i = 0; i < (rating - 0.5); i++, starCounter++)
          const Icon(Icons.star_sharp, size: 16, color: Colors.orange),
        //print half star
        if (rating % 1 == 0.5)
          for (var i = 0; i < 1; i++, starCounter++)
            const Icon(Icons.star_half, size: 16, color: Colors.orange),
        //print black star
        for (var i = 0; i < 5 && starCounter < 5; i++, starCounter++)
          const Icon(Icons.star_sharp, size: 16, color: Colors.grey),
      ],
    );
  }
}

// Widget getWidget(double rating, int starCounter) {
//   if (rating % 1 == 0.5) {
//     starCounter++;
//     return const Icon(Icons.star_half, size: 16, color: Colors.orange);
//   } else {
//     return Text('');
//   }
// }

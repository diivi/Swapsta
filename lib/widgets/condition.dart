import 'package:flutter/material.dart';

//doesnt display half stars rn
class ConditionStars extends StatelessWidget {
  double rating;
  ConditionStars(this.rating);

  @override
  Widget build(BuildContext context) {
    int starCounter = 0;
    return Row(
      children: [
        for (var i = 0; i < rating; i++, starCounter++)
          const Icon(
            Icons.star_sharp,
            size: 16,
            color: Colors.orange,
          ),
        for (var i = 0; i < 5 && starCounter < 5; i++, starCounter++)
          const Icon(Icons.star_sharp, size: 16, color: Colors.grey),
      ],
    );
  }
}

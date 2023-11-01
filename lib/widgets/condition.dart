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
          const Icon(
            Icons.star_sharp,
            size: 16,
            color: Colors.black,
          ),
        //print half star
        //
        if (rating % 1 == 0.5)
          for (var i = 0; i < 1; i++, starCounter++)
            ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  stops: const [0, 0.5, 0.5],
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.grey.withOpacity(1)
                  ],
                ).createShader(rect);
              },
              child: SizedBox(
                width: 16,
                height: 16,
                child: Icon(
                  Icons.star_sharp,
                  size: 16,
                  color: Colors.grey[300],
                ),
              ),
            ),
        //print blank star
        for (var i = 0; i < 5 && starCounter < 5; i++, starCounter++)
          const Icon(Icons.star_sharp, size: 16, color: Colors.grey),
      ],
    );
  }
}

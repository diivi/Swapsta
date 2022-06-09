import 'package:flutter/material.dart';

class SwappableCard extends StatelessWidget {
  const SwappableCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.ownerName,
      required this.imageUrls,
      required this.condition,
      required this.isWishlisted})
      : super(key: key);

  final String id;
  final String name;
  final String ownerName;
  final List<String> imageUrls;
  final bool isWishlisted;
  final double condition;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Container(
            color: Colors.white,
            child: Column(children: [
              Stack(
                children: [
                  Image.network(imageUrls[0],
                      width: double.infinity, height: 100, fit: BoxFit.cover),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 300,
                      height: 10,
                      color: Colors.white70,
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
              Text(ownerName),
            ])));
  }
}




      // child: Image.network(
      //   imageUrls[0],
      //   fit: BoxFit.cover,
      // ),
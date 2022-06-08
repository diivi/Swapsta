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
      child: Image.network(
        imageUrls[0],
        fit: BoxFit.cover,
      ),
    );
  }
}

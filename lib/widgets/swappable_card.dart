import 'package:flutter/material.dart';

class SwappableCard extends StatelessWidget {
  const SwappableCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.ownerName,
      required this.ownerImageUrl,
      required this.imageUrls,
      required this.condition,
      required this.isWishlisted})
      : super(key: key);

  final String id;
  final String name;
  final String ownerName;
  final String ownerImageUrl;
  final List<String> imageUrls;
  final bool isWishlisted;
  final double condition;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Ink.image(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrls[0]),
              height: 160,
            ),
            const Positioned(
              bottom: 10,
              right: 10,
              child: Icon(Icons.favorite_border, color: Colors.orange),
            )
          ]),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              //circle avatar dp
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(ownerImageUrl),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}

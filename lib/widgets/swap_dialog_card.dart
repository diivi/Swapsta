import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/swappable.dart';
import '../providers/auth_provider.dart';
import '../screens/swappable_screen.dart';
import 'dart:convert';
import 'condition.dart';

class SelectItemCard extends StatelessWidget {
  final Swappable swappable;

  final VoidCallback onTap;
  final bool selected;

  const SelectItemCard({
    Key? key,
    required this.swappable,
    required this.onTap,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ?? false ? Colors.orange : Colors.transparent,
            width: selected ?? false ? 2 : 0,
          ),
        ),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
          highlightColor: const Color(0x00ffffff),
          onTap: onTap,
          child: Column(
            children: [
              Stack(
                children: [
                  Material(
                    child: Ink(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(swappable.imageUrls[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * .18,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.transparent,
                        child: ConditionStars(swappable.condition)),
                  )
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      swappable.name,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      'Swap Requests: ${swappable.swapRequests}',
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

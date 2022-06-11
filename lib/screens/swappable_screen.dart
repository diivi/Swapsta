import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import '../providers/swappable_provider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class SwappableScreen extends StatelessWidget {
  static const routeName = '/swappable';

  const SwappableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    final swappable = routeArgs as Swappable;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Hero(
        tag: 'swappable-${swappable.id}',
        child: ImageSlideshow(
          width: double.infinity,
          height: 300,
          initialPage: 0,
          indicatorColor: Colors.orange,
          isLoop: swappable.imageUrls.length > 1,
          autoPlayInterval: 4000,
          children: swappable.imageUrls
              .map(
                (url) => Stack(
                  children: [
                    Image.network(
                      url,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 30,
                            spreadRadius: 0,
                            offset: const Offset(0, -30),
                            inset: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

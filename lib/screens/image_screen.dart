import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ImageScreen extends StatefulWidget {
  final List<String> url;
  const ImageScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .9,
          initialPage: 0,
          indicatorColor: Colors.orange,
          isLoop: widget.url.length > 1,
          autoPlayInterval: 4000,
          children: widget.url
              .map(
                (url) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        Image.network(
                          url,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

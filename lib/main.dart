import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Hello')),
      bottomNavigationBar: DotNavigationBar(
          dotIndicatorColor: Colors.orange,
          currentIndex: currentIndex,
          enablePaddingAnimation: false,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Colors.orange,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              selectedColor: Colors.orange,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.search),
              selectedColor: Colors.orange,
            ),
          ]),
    );
  }
}

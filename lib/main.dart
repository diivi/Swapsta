import 'package:flutter/material.dart';
import 'package:swapsta/screens/explore_screen.dart';
import 'package:swapsta/screens/profile_screen.dart';
import 'package:swapsta/screens/swap_screen.dart';
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
  late final List<Map<String, dynamic>> _pages;
  int _pageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _pages = [
      {'page': const ExploreScreen(), 'title': 'Explore'},
      {'page': const SwapScreen(), 'title': 'Swap'},
      {'page': const ProfileScreen(), 'title': 'Profile'},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex]['page'],
      bottomNavigationBar: DotNavigationBar(
          dotIndicatorColor: Colors.orange,
          currentIndex: currentIndex,
          enablePaddingAnimation: false,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              _pageIndex = index;
            });
          },
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Colors.orange,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.swap_horiz),
              selectedColor: Colors.orange,
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              selectedColor: Colors.orange,
            ),
          ]),
    );
  }
}

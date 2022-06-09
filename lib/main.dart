import 'package:flutter/material.dart';
import 'package:swapsta/screens/explore_screen.dart';
import 'package:swapsta/screens/profile_screen.dart';
import 'package:swapsta/screens/swap_screen.dart';
import 'package:swapsta/screens/add_item_screen.dart';
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
        scaffoldBackgroundColor: const Color(0xFFF9F6F2),
      ),
      home: const Home(),
      routes: {"/add-item": (context) => const AddItemScreen()},
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
  int _screenIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  final _screens = [
    ExploreScreen(),
    const SwapScreen(),
    const ProfileScreen(),
    const AddItemScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'RedHatDisplay',
      ),
      home: Scaffold(
        body: _screens[_screenIndex],
        extendBody: true,
        bottomNavigationBar: DotNavigationBar(
            dotIndicatorColor: Colors.orange,
            currentIndex: _screenIndex,
            enablePaddingAnimation: false,
            onTap: (int index) {
              _selectPage(index);
            },
            items: [
              DotNavigationBarItem(
                icon: const Icon(Icons.explore),
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
      ),
    );
  }
}

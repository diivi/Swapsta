import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/icons/swapcons_icons.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/providers/screen_provider.dart';
import 'package:swapsta/screens/add_item_screen.dart';
import 'package:swapsta/screens/explore_screen.dart';
import 'package:swapsta/screens/profile_screen.dart';
import 'package:swapsta/screens/swap_screen.dart';
import 'package:swapsta/widgets/settings_sidebar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _screens = [
    const ExploreScreen(),
    const SwapScreen(),
    const ProfileScreen(),
    const AddItemScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    int screenIndex = Provider.of<ScreenProvider>(context).screenIndex;
    
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 20,
          left: 0,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/img/swap_straight.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3),
                  BlendMode.modulate,
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: _screens[screenIndex],
          bottom: false,
        )
      ]),
      extendBody: true,
      bottomNavigationBar: Consumer<BottomBarVisibilityProvider>(
        builder: (context, bottomBarVisibilityProvider, _) => AnimatedOpacity(
          opacity: bottomBarVisibilityProvider.isVisible ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: IgnorePointer(
            ignoring: !bottomBarVisibilityProvider.isVisible,
            child: DotNavigationBar(
              dotIndicatorColor: Colors.orange,
              currentIndex: screenIndex,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                )
              ],
              enablePaddingAnimation: false,
              onTap: (int index) {
                Provider.of<ScreenProvider>(context, listen: false)
                    .setScreenIndex(index);
              },
              items: [
                DotNavigationBarItem(
                  icon: const Icon(Icons.explore),
                  selectedColor: Colors.orange,
                ),
                DotNavigationBarItem(
                  icon: const Icon(Swapcons.swap),
                  selectedColor: Colors.orange,
                ),
                DotNavigationBarItem(
                  icon: const Icon(Icons.account_circle_outlined),
                  selectedColor: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const Drawer(
        child: SettingsDrawer(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/providers/auth_provider.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/providers/recieved_swap_provider.dart';
import 'package:swapsta/providers/screen_provider.dart';
import 'package:swapsta/providers/sent_swaps_provider.dart';
import 'package:swapsta/providers/swap_history_provider.dart';
import 'package:swapsta/screens/explore_screen.dart';
import 'package:swapsta/screens/profile_screen.dart';
import 'package:swapsta/screens/swap_screen.dart';
import 'package:swapsta/screens/add_item_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:swapsta/screens/swappable_screen.dart';
import 'package:swapsta/icons/swapcons_icons.dart';
import 'package:swapsta/widgets/settings_sidebar.dart';
import './providers/swappables_provider.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
}

Future initialization(BuildContext? context) async {
  await Future.delayed(
    Duration(seconds: 1),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(
            id: '1',
            fullName: 'Divyansh Singh',
            email: 'ds192@snu.edu.in',
            imageUrl: 'https://avatars.githubusercontent.com/u/41837037?v=4',
            wishlist: {
              "2": true,
              "3": true,
              "4": true,
            },
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Swappables(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomBarVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SentSwap(),
        ),
        ChangeNotifierProvider(
          create: (_) => SwapHistory(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecievedSwap(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: const Color(0xFFF9F6F2),
          fontFamily: 'RedHatDisplay',
        ),
        home: const Home(),
        routes: {
          AddItemScreen.routeName: (context) => const AddItemScreen(),
          SwappableScreen.routeName: (context) => const SwappableScreen(),
          SwapScreen.routeName: (context) => const SwapScreen(),
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

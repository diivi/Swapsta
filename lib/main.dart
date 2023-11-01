import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swappable.dart';
import 'package:swapsta/providers/Auth/google_sign_in.dart';
import 'package:swapsta/providers/auth_provider.dart';
import 'package:swapsta/providers/bottom_nav_visibility_provider.dart';
import 'package:swapsta/providers/screen_provider.dart';
import 'package:swapsta/screens/auth_screen.dart';
import 'package:swapsta/screens/edit_item_screen.dart';
// import 'package:swapsta/screens/explore_screen.dart';
import 'package:swapsta/screens/home_screen.dart';
import 'package:swapsta/screens/feedback_screen.dart';
// import 'package:swapsta/screens/profile_screen.dart';
import 'package:swapsta/screens/swap_screen.dart';
import 'package:swapsta/screens/add_item_screen.dart';
// import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:swapsta/screens/swappable_screen.dart';
import './providers/swappables_provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            id: '',
            fullName: '',
            email: '',
            imageUrl: '',
            wishlist: {},
            loggedIn: false,
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
          create: (_) => SwappableProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'RedHatDisplay',
        ),
        home: const Home(),
        routes: {
          AddItemScreen.routeName: (context) => const AddItemScreen(),
          SwappableScreen.routeName: (context) => const SwappableScreen(),
          SwapScreen.routeName: (context) => const SwapScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          FeedbackScreen.routeName: (context) => const FeedbackScreen(),
          EditItemScreen.routeName: (context) => const EditItemScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Somethng went wrong'),
            );
          }
          return AuthScreen();
        },
      ),
    );
  }
}

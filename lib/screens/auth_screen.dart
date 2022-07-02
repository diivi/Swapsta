import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .1,
          right: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * .05,
          bottom: MediaQuery.of(context).size.height * .03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/img/swap_straight.png',
                      height: MediaQuery.of(context).size.width * .11,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                    Text(
                      'swapsta',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/img/login_screen.png',
                  height: MediaQuery.of(context).size.height * .5,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'swap, don\'t shop',
                          style: TextStyle(
                            fontFamily: 'AbhayaLibre',
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -150,
                  left: 100,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage('assets/img/swap_straight.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.15),
                          BlendMode.modulate,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .57,
                  child: ElevatedButton(
                    onPressed: () {
                      user.toggleAuthState(true);
                      // Navigator.pushNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 2.0,
                        padding: EdgeInsets.all(7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/img/google_icon.png',
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        Text(
                          'Continue with Google',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/providers/Auth/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .1,
          right: MediaQuery.of(context).size.width * .1,
          top: MediaQuery.of(context).size.height * 0,
          bottom: MediaQuery.of(context).size.height * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                //Container#1: Image
                Container(
                  width: 375,
                  height: 473,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/img/login_screen.png'), // Corrected this line
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                //Container#2: Text and Button
                Container(
                  width: 321,
                  height: 277.34,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 321,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Swap Without ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.80,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: 'Interruption',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.80,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Fraunces',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: ', Unleash the Fun, Let the ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.80,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: 'Energy Flow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.80,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Fraunces',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: '!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.80,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 270,
                        child: Text(
                          'Trade your unused belongings with fellow students and discover new treasures while decluttering your space',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13.22,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.10,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 68, vertical: 18),
                              decoration: BoxDecoration(
                                color: Color(0xFF222222),
                                borderRadius: BorderRadius.circular(46.75),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 18.34,
                                    height: 18.34,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0.38,
                                          top: 0.38,
                                          child: Container(
                                            width: 17.58,
                                            height: 17.58,
                                            child: Stack(children: []),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/img/google_icon.png',
                                    height: MediaQuery.of(context).size.height *
                                        0.023,
                                  ),
                                  SizedBox(width: 9.52),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.08,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      letterSpacing: -0.14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 9),
                            SizedBox(
                              width: 287,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'By continuing you agree to our',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 11.92,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' terms of service',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 11.92,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' and',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 11.92,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' privacy policy',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontSize: 11.92,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

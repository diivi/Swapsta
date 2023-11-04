import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth/google_sign_in.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      top: false,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(authUser.photoURL!),
                    radius: 30,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authUser.displayName!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        authUser.email!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Text('About'),
              leading: Icon(
                Icons.info_outline_rounded,
                color: Colors.black,
              ),
            ),
            const ListTile(
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('Feedback'),
              leading: Icon(
                Icons.feedback_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/feedback_screen');
              },
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: const Text('Logout'),
                  onTap: () async {
                    try {
                      final provider = Provider.of<GoogleSignInProvider>(
                        context,
                        listen: false,
                      );
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // Prevent dismissing the dialog by tapping outside
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(), // Show the circular progress indicator
                                SizedBox(height: 16),
                                Text(
                                  "Logging Out...",
                                ), // Optional: Add a message
                              ],
                            ),
                          );
                        },
                      );
                      await provider.logout();
                    } catch (e) {
                      print(e);
                      Navigator.pop(context);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

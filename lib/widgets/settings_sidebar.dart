import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
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
                    backgroundImage: NetworkImage(user.imageUrl),
                    radius: 30,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
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
                color: Colors.orange,
              ),
            ),
            const ListTile(
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: Colors.orange,
              ),
            ),
            const ListTile(
              title: Text('Feedback'),
              leading: Icon(
                Icons.feedback_rounded,
                color: Colors.orange,
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.orange,
                  ),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

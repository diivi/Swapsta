import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    final authUser = FirebaseAuth.instance.currentUser!;
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      height: MediaQuery.of(context).size.height * .12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(authUser.photoURL!),
                  radius: 45,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authUser.displayName!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.fade,
                      ),
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      authUser.email!,
                      style: const TextStyle(
                        color: Color.fromARGB(131, 0, 0, 0),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    const Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: Ink(
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.orange,
                            width: 1.5,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
                          highlightColor: Colors.transparent,
                          onTap: (() {}),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              // horizontal: 5,
                              vertical: 3,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Edit Profile',
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.orange,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}

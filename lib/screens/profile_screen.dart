import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/screens/swap_screen.dart';
import '../providers/auth_provider.dart';
import '../globals.dart' as globals;
import '../widgets/swappable_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
    final wishlistedSwappables = globals.wishlistedSwappables;

    TabController _tabController = TabController(length: 2, vsync: this);
    List<Map<String, dynamic>> tabsData = [
      {
        "icon": Icons.lightbulb_outlined,
        "text": "My Items",
      },
      {
        "icon": Icons.favorite_outline_rounded,
        "text": "Favorites",
      }
    ];
    return Column(
      children: [
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.imageUrl),
                      radius: 45,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.fade,
                        ),
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Color.fromARGB(131, 0, 0, 0),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: Ink(
                          width: MediaQuery.of(context).size.width * 0.32,
                          // width: 150,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.orange,
                              width: 2,
                            ),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
                            highlightColor: Colors.transparent,
                            onTap: (() {}),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 3,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Edit Profile',
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                            fontSize: 15,
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
                ],
              ),
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.orange,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.19,
          ),
          child: TabBar(
            splashFactory: NoSplash.splashFactory,
            labelColor: Colors.orange,
            unselectedLabelColor: const Color.fromRGBO(158, 158, 158, .5),
            indicator: const CustomTabIndicator(),
            indicatorPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.035,
            ),
            tabs: tabsData
                .map((tabData) => _buildIcons(
                    context: context,
                    icon: tabData["icon"],
                    text: tabData["text"]))
                .toList(),
            controller: _tabController,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const Center(child: Text('My Items')),
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                itemCount: wishlistedSwappables.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: wishlistedSwappables[i],
                  child: const SwappableCard(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildIcons({
  required BuildContext context,
  required IconData icon,
  required String text,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.09,
    child: Tab(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 28,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    )),
  );
}

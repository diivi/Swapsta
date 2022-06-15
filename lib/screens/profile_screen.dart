import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/screens/swap_screen.dart';
import '../providers/auth_provider.dart';
import '../globals.dart' as globals;
import '../widgets/profile_header.dart';
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
        const ProfileHeader(),
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.15,
          ),
          child: TabBar(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            labelColor: Colors.orange,
            unselectedLabelColor: const Color.fromRGBO(158, 158, 158, .35),
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .025,
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
                itemBuilder: (ctx, i) {
                  return SwappableCard(
                    swappable: wishlistedSwappables[i],
                  );
                },
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

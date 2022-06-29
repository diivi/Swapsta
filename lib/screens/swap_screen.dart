import 'package:flutter/material.dart';
import 'package:swapsta/widgets/recieved_swap_grid.dart';
import 'package:swapsta/widgets/sent_swap_grid.dart';
import 'package:swapsta/widgets/swap_history_grid.dart';
import 'dart:math' as math;
import '../widgets/swapscreen_header.dart';

class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);
  static const routeName = '/swap-screen';

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> with TickerProviderStateMixin {
  String searchQuery = '';

  void _onSearchQueryChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    List<Map<String, dynamic>> tabsData = [
      {
        "child": Transform.rotate(
          angle: -math.pi / 5,
          child: const Icon(
            Icons.send,
            size: 28,
          ),
        ),
        "text": "Sent",
      },
      {
        "child": const Icon(
          Icons.inbox,
          size: 32,
        ),
        "text": "Recieved",
      },
      {
        "child": const Icon(
          Icons.history,
          size: 32,
        ),
        "text": "History",
      },
    ];
    return Column(
      children: [
        SwapscreenHeader(
          handleSearch: _onSearchQueryChanged,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
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
                .map(
                  (tabData) => _buildIcons(
                      context: context,
                      child: tabData["child"],
                      text: tabData["text"]),
                )
                .toList(),
            controller: _tabController,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SentSwapGrid(
                    searchQuery: searchQuery,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecievedSwapGrid(searchQuery: searchQuery, tabSwitcher: _tabController),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SwapHistoryGrid(
                    searchQuery: searchQuery,
                  ),
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
  required Widget child,
  required String text,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.09,
    child: Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child,
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  const CustomTabIndicator({
    this.radius = 8,
    this.indicatorHeight = 4,
    this.color = Colors.orange,
  });

  @override
  _CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
      this,
      onChanged,
      radius,
      color,
      indicatorHeight,
    );
  }
}

class _CustomPainter extends BoxPainter {
  final CustomTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;

  _CustomPainter(
    this.decoration,
    VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
  ) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    final Paint paint = Paint();
    double xAxisPos = offset.dx + configuration.size!.width / 2;
    double yAxisPos =
        offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;

    RRect fullRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width / 3,
        height: indicatorHeight,
      ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    canvas.drawRRect(fullRect, paint);
  }
}

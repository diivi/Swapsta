import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapsta/models/swappable.dart';
import '../widgets/swap_dialog_card.dart';

class SwapDialog extends StatefulWidget {
  const SwapDialog({Key? key}) : super(key: key);

  @override
  State<SwapDialog> createState() => _SwapDialog();
}

class _SwapDialog extends State<SwapDialog> {
  int optionSelected = 0;

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;
    final swappableProvider = Provider.of<SwappableProvider>(context);
    final swappables = swappableProvider.swappables;
    final isFetching = swappableProvider.isFetching;
    final filteredSwappables = swappables
        .where((swappable) => swappable.ownerId == authUser.email)
        .toList();
    return AlertDialog(
      backgroundColor: Color.fromRGBO(249, 246, 242, 1),
      // contentPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Select your Item'),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: const Color.fromRGBO(255, 152, 0, 0.2),
            highlightColor: const Color(0x00ffffff),
            child: Icon(
              Icons.close,
              color: Color.fromRGBO(255, 152, 0, 1),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),

      content: (!isFetching)
          ? Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .8,
              child: Stack(alignment: Alignment.center, children: [
                GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0.0),
                  itemCount: filteredSwappables.length + 1,
                  controller: ScrollController(),
                  itemBuilder: (ctx, i) {
                    if (i == 0) {
                      return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color.fromRGBO(255, 142, 60, 0.7),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.white,
                            iconSize: 50,
                            onPressed: () {},
                          ));
                    }
                    return SelectItemCard(
                      swappable: filteredSwappables[i - 1],
                      onTap: () => checkOption(i + 1),
                      selected: i + 1 == optionSelected,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.35),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
                Positioned.fill(
                  bottom: 20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        'Choose Item',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (optionSelected != 0) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Swap Request Sent"),
                            duration: Duration(milliseconds: 1000),
                          ));
                          Navigator.pop(context);
                        } else {
                          null;
                        }
                      },
                    ),
                  ),
                ),
              ]),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

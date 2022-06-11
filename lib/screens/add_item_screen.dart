import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  static const routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('add item')),
    );
  }
}

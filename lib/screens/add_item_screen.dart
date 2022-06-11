import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  static const routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: const Center(child: Text('add item')),
    );
  }
}

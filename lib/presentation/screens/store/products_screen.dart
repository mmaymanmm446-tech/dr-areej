import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('المتجر')), body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: 6, itemBuilder: (_, index) => Card(margin: const EdgeInsets.all(8), child: Center(child: Text('منتج ${index + 1}')))));
  }
}
